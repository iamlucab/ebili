<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class MemberProductController extends Controller
{
    /**
     * Display a listing of active and in-stock products.
     */
    public function index(Request $request)
    {
        $query = Product::where('active', 1)->where('stock_quantity', '>', 0);

        // Optional: search filter
        if ($search = $request->input('q')) {
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('description', 'like', "%{$search}%");
            });
        }

        // Category filtering
        if ($categoryId = $request->input('category')) {
            $query->where('category_id', $categoryId);
        }

        // Check if it's an AJAX request for loading more products
        if ($request->ajax() || $request->input('ajax')) {
            // For AJAX requests, we want to load 10 products at a time starting from the specified page
            $page = $request->input('page', 1);
            $products = $query->latest()->skip(($page - 1) * 10)->take(10)->get();

            // Check if there are more products to load
            $totalProducts = $query->count();
            $hasMore = ($page * 10) < $totalProducts;

            // Return JSON response with the product grid HTML
            return response()->json([
                'success' => true,
                'html' => view('shop.partials.product-grid', ['products' => $products])->render(),
                'hasMore' => $hasMore,
                'totalProducts' => $totalProducts,
                'productsCount' => $products->count()
            ]);
        }

        // For regular requests, use pagination
        $products = $query->latest()->paginate(12);

        // Get all categories for filtering
        $categories = \App\Models\Category::orderBy('name')->get();

        // Calculate additional variables needed by the view
        $totalProducts = Product::where('active', 1)->where('stock_quantity', '>', 0)->count();
        $hasMore = $products->hasMorePages();

        return view('shop.index', compact('products', 'categories', 'hasMore', 'totalProducts'));
    }

    /**
     * Show the details of a single product.
     */
    public function show(Product $product)
    {
        if (!$product->active || $product->stock_quantity <= 0) {
            abort(404);
        }

        return view('shop.show', compact('product'));
    }
}
