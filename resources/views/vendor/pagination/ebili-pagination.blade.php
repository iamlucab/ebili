@if ($paginator->hasPages())
    <nav role="navigation" aria-label="Pagination Navigation" class="ebili-pagination-nav">
        <div class="ebili-pagination-wrapper">
            {{-- Previous Page Link --}}
            @if ($paginator->onFirstPage())
                <span class="ebili-pagination-item ebili-pagination-item-disabled" aria-disabled="true" aria-label="@lang('pagination.previous')">
                    <span class="ebili-pagination-link" aria-hidden="true">
                        <i class="bi bi-chevron-left"></i>
                    </span>
                </span>
            @else
                <a href="{{ $paginator->previousPageUrl() }}" class="ebili-pagination-item" rel="prev" aria-label="@lang('pagination.previous')">
                    <span class="ebili-pagination-link">
                        <i class="bi bi-chevron-left"></i>
                    </span>
                </a>
            @endif

            {{-- Pagination Elements --}}
            @foreach ($elements as $element)
                {{-- "Three Dots" Separator --}}
                @if (is_string($element))
                    <span class="ebili-pagination-item ebili-pagination-item-disabled" aria-disabled="true">
                        <span class="ebili-pagination-link">{{ $element }}</span>
                    </span>
                @endif

                {{-- Array Of Links --}}
                @if (is_array($element))
                    @foreach ($element as $page => $url)
                        @if ($page == $paginator->currentPage())
                            <span class="ebili-pagination-item ebili-pagination-item-active" aria-current="page">
                                <span class="ebili-pagination-link">{{ $page }}</span>
                            </span>
                        @else
                            <a href="{{ $url }}" class="ebili-pagination-item" aria-label="@lang('Go to page :page', ['page' => $page])">
                                <span class="ebili-pagination-link">{{ $page }}</span>
                            </a>
                        @endif
                    @endforeach
                @endif
            @endforeach

            {{-- Next Page Link --}}
            @if ($paginator->hasMorePages())
                <a href="{{ $paginator->nextPageUrl() }}" class="ebili-pagination-item" rel="next" aria-label="@lang('pagination.next')">
                    <span class="ebili-pagination-link">
                        <i class="bi bi-chevron-right"></i>
                    </span>
                </a>
            @else
                <span class="ebili-pagination-item ebili-pagination-item-disabled" aria-disabled="true" aria-label="@lang('pagination.next')">
                    <span class="ebili-pagination-link" aria-hidden="true">
                        <i class="bi bi-chevron-right"></i>
                    </span>
                </span>
            @endif
        </div>
    </nav>

    <style>
        /* Import Poppins font if not already loaded */
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        .ebili-pagination-nav {
            display: flex;
            justify-content: center;
            margin: 1.5rem 0;
            width: 100%;
        }

        .ebili-pagination-wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.5rem;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(111, 66, 193, 0.1);
            border: 1px solid rgba(111, 66, 193, 0.1);
            backdrop-filter: blur(5px);
            max-width: 100%;
            overflow-x: auto;
            padding: 10px;
            /* Prevent overlapping with other elements */
            z-index: 10;
            position: relative;
        }

        .ebili-pagination-item {
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 40px;
            height: 40px;
            border-radius: 12px;
            text-decoration: none;
            transition: all 0.3s ease;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            font-size: 0.9rem;
            border: 2px solid transparent;
            flex-shrink: 0; /* Prevent items from shrinking */
        }

        .ebili-pagination-link {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            height: 100%;
            color: #64189e;
        }

        .ebili-pagination-item:hover:not(.ebili-pagination-item-disabled):not(.ebili-pagination-item-active) {
            background: linear-gradient(135deg, #f3f0ff 0%, rgba(111, 66, 193, 0.1) 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(111, 66, 193, 0.2);
            border-color: #64189e;
        }

        .ebili-pagination-item-active {
            background: linear-gradient(135deg, #64189e 0%, #4e117c 100%);
            box-shadow: 0 4px 15px rgba(111, 66, 193, 0.3);
            border-color: #64189e;
        }

        .ebili-pagination-item-active .ebili-pagination-link {
            color: white;
        }

        .ebili-pagination-item-disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .ebili-pagination-item-disabled .ebili-pagination-link {
            color: #6c757d;
        }

        /* Mobile responsive design */
        @media (max-width: 768px) {
            .ebili-pagination-wrapper {
                gap: 0.25rem;
                padding: 8px;
            }

            .ebili-pagination-item {
                min-width: 36px;
                height: 36px;
                border-radius: 10px;
                font-size: 0.8rem;
            }

            .ebili-pagination-link {
                padding: 0 8px;
            }
        }

        /* Extra small devices */
        @media (max-width: 480px) {
            .ebili-pagination-wrapper {
                gap: 0.1rem;
                padding: 6px;
            }

            .ebili-pagination-item {
                min-width: 32px;
                height: 32px;
                border-radius: 8px;
                font-size: 0.75rem;
            }
        }

        /* Prevent text selection on pagination items */
        .ebili-pagination-item {
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        /* Ensure proper scrolling behavior on mobile */
        .ebili-pagination-wrapper {
            -webkit-overflow-scrolling: touch;
        }
    </style>
@endif
