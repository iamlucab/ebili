<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100 bg-light">
    <div class="container text-center">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8 col-sm-10">
                <div class="card shadow">
                    <div class="card-body p-5">
                        <h1 class="display-1 text-primary fw-bold">404</h1>
                        <h2 class="mb-4">Page Not Found</h2>
                        <p class="lead mb-4">
                            Sorry, the page you're looking for doesn't exist or has been moved.
                        </p>
                        <div class="d-grid gap-2 d-md-flex justify-content-center">
                            <a href="{{ route('home') }}" class="btn btn-primary btn-lg px-4">
                                <i class="bi bi-house-door me-2"></i>Go Home
                            </a>
                            <a href="{{ route('login') }}" class="btn btn-outline-primary btn-lg px-4">
                                <i class="bi bi-box-arrow-in-right me-2"></i>Login
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
