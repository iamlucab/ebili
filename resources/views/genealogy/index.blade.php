@extends('adminlte::page')
@section('title', 'Genealogy Tree')
@section('content_header')
    <h1>My Network</h1>
@stop

@section('content')
    <div class="row">
        <div class="col-12">
            <!-- Visual Chart View (Desktop) -->
            <div class="card d-none d-md-block">
                <div class="card-header">
                    <h3 class="card-title">Network View</h3>
                </div>
                <div class="card-body">
                    <div id="chart-container" class="chart-container">
                        <div id="chart_div" class="org-chart"></div>
                    </div>
                    <div class="mt-3 text-muted">
                        <small><i class="fas fa-info-circle"></i> Use pinch-to-zoom </small>
                    </div>
                </div>
            </div>

            <!-- Collapsible Tree View (Mobile) -->
            <div class="card d-md-none">
                <div class="card-header">
                    <h3 class="card-title">Network Tree</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <div id="tree-container" class="tree-container">
                        <!-- Tree will be populated by JavaScript -->
                    </div>
                </div>
            </div>

            <!-- Toggle View Button for Mobile -->
            <div class="d-md-none text-center mb-3">
                <button id="toggle-view" class="btn btn-primary">
                    <i class="bi bi-arrow-left-right"></i> Switch to Visual View
                </button>
                <div class="mt-2 text-muted">
                    <small>Click between tree and visual views</small>
                </div>
            </div>

            <!-- Visual Chart View (Mobile - Initially Hidden) -->
            <div class="card d-md-none" id="mobile-chart-card" style="display: none;">
                <div class="card-header">
                    <h3 class="card-title">Network Visual</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <div id="mobile-chart-container" class="chart-container">
                        <div id="mobile_chart_div" class="org-chart"></div>
                    </div>
                    <div class="mt-3 text-muted">
                        <small><i class="fas fa-info-circle"></i> Use pinch-to-zoom to view</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
@stop

@section('css')
    <style>
        .chart-container {
            width: 100%;
            overflow: auto;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
            min-height: 500px;
            touch-action: manipulation;
        }

        .org-chart {
            min-width: 100%;
            min-height: 500px;
        }

        .tree-container {
            max-height: 500px;
            overflow-y: auto;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .tree-node {
            display: flex;
            align-items: center;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 10px;
            background-color: white;
        }

        .tree-node img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            object-fit: cover;
        }

        .tree-node-content {
            flex: 1;
        }

        .tree-node-name {
            font-weight: bold;
            margin-bottom: 3px;
        }

        .tree-node-children {
            margin-left: 30px;
            margin-top: 10px;
            display: none;
        }

        .tree-node.expanded + .tree-node-children {
            display: block;
        }

        .toggle-children {
            background: none;
            border: none;
            font-size: 16px;
            margin-right: 10px;
            cursor: pointer;
            width: 24px;
            text-align: center;
        }

        /* Mobile-specific styles */
        @media (max-width: 767.98px) {
            .chart-container {
                min-height: 400px;
                padding: 5px;
            }

            .org-chart {
                min-height: 400px;
                transform-origin: 0 0;
            }

            .card-body {
                padding: 0.5rem;
            }

            .tree-container {
                max-height: 400px;
                padding: 5px;
            }

            .tree-node {
                padding: 8px;
                margin-bottom: 8px;
            }

            .tree-node img {
                width: 35px;
                height: 35px;
            }

            .tree-node-children {
                margin-left: 20px;
            }
        }

        /* Ensure chart is responsive on all devices */
        .google-visualization-orgchart-table {
            width: 100% !important;
        }

        .google-visualization-orgchart-node {
            font-size: 12px !important;
            padding: 5px !important;
            border: 1px solid #ccc !important;
            border-radius: 4px !important;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1) !important;
            max-width: 120px !important;
            word-wrap: break-word !important;
        }

        @media (max-width: 575.98px) {
            .google-visualization-orgchart-node {
                font-size: 10px !important;
                padding: 3px !important;
                max-width: 80px !important;
                word-wrap: break-word !important;
            }

            .google-visualization-orgchart-node img {
                width: 25px !important;
                height: 25px !important;
            }
        }

        /* Ensure profile images are visible */
        .tree-node .profile-img {
            width: 100% !important;
            height: auto !important;
            max-width: 50px !important;
            max-height: 50px !important;
            border-radius: 50% !important;
            object-fit: cover !important;
        }

        @media (max-width: 575.98px) {
            .tree-node .profile-img {
                max-width: 30px !important;
                max-height: 30px !important;
            }
        }
    </style>
@stop

@section('js')
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {packages:["orgchart"]});
      google.charts.setOnLoadCallback(drawChart);

      // Parse chart data for tree view
      var chartData = [
           @foreach($chartData as $row)
    [
        { v: '{{ $row[0]['v'] }}', f: `{!! $row[0]['f'] !!}` },
        '{{ $row[1] }}'
    ],
@endforeach
      ];

      function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Name');
        data.addColumn('string', 'Manager');

        data.addRows(chartData);

        // Draw desktop chart
        var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
        chart.draw(data, {allowHtml:true});

        // Draw mobile chart
        var mobileChart = new google.visualization.OrgChart(document.getElementById('mobile_chart_div'));
        mobileChart.draw(data, {allowHtml:true});

        // Add responsive behavior
        window.addEventListener('resize', function() {
            chart.draw(data, {allowHtml:true});
            mobileChart.draw(data, {allowHtml:true});
        });
      }

      // Build tree view from chart data
      function buildTreeView() {
          var treeContainer = document.getElementById('tree-container');
          if (!treeContainer) return;

          // Create a map of nodes
          var nodeMap = {};
          chartData.forEach(function(row) {
              var node = {
                  id: row[0].v,
                  html: row[0].f,
                  parent: row[1],
                  children: []
              };
              nodeMap[node.id] = node;
          });

          // Build parent-child relationships
          Object.values(nodeMap).forEach(function(node) {
              if (node.parent && nodeMap[node.parent]) {
                  nodeMap[node.parent].children.push(node);
              }
          });

          // Find root node (node without parent or with parent not in map)
          var rootNodes = Object.values(nodeMap).filter(function(node) {
              return !node.parent || !nodeMap[node.parent];
          });

          // Build tree HTML
          var treeHtml = '';
          rootNodes.forEach(function(rootNode) {
              treeHtml += buildTreeNode(rootNode, 0);
          });

          treeContainer.innerHTML = treeHtml;

          // Add event listeners for toggle buttons
          document.querySelectorAll('.toggle-children').forEach(function(button) {
              button.addEventListener('click', function() {
                  var nodeId = this.getAttribute('data-node');
                  var nodeElement = document.querySelector('[data-node-id="' + nodeId + '"]');
                  if (nodeElement) {
                      nodeElement.classList.toggle('expanded');
                      this.textContent = nodeElement.classList.contains('expanded') ? '-' : '+';
                  }
              });
          });
      }

      function buildTreeNode(node, level) {
          var hasChildren = node.children && node.children.length > 0;
          var indent = level * 20;

          var html = '<div class="tree-node" data-node-id="' + node.id + '" style="margin-left: ' + indent + 'px;">';

          if (hasChildren) {
              html += '<button class="toggle-children" data-node="' + node.id + '">+</button>';
          } else {
              html += '<span style="width: 24px; display: inline-block;"></span>';
          }

          // Extract image and name from HTML
          var parser = new DOMParser();
          var doc = parser.parseFromString(node.html, 'text/html');
          var img = doc.querySelector('img');
          var name = doc.querySelector('strong') ? doc.querySelector('strong').textContent : node.id;

          if (img) {
              html += img.outerHTML.replace('<img', '<img class="profile-img"');
          } else {
              // Add default profile image if none exists
              html += '<img class="profile-img" src="{{ asset('images/default-profile.png') }}" alt="Profile">';
          }

          html += '<div class="tree-node-content">';
          html += '<div class="tree-node-name">' + name + '</div>';
          html += '</div>';
          html += '</div>';

          if (hasChildren) {
              html += '<div class="tree-node-children" data-node-id="' + node.id + '" style="margin-left: ' + indent + 'px;">';
              node.children.forEach(function(child) {
                  html += buildTreeNode(child, level + 1);
              });
              html += '</div>';
          }

          return html;
      }

      // Add mobile touch support for chart navigation
      document.addEventListener('DOMContentLoaded', function() {
          // Build tree view
          buildTreeView();

          // Toggle view button
          var toggleButton = document.getElementById('toggle-view');
          var mobileChartCard = document.getElementById('mobile-chart-card');
          var treeCard = document.querySelector('.card.d-md-none');

          if (toggleButton) {
              toggleButton.addEventListener('click', function() {
                  if (mobileChartCard.style.display === 'none') {
                      mobileChartCard.style.display = 'block';
                      treeCard.style.display = 'none';
                      this.innerHTML = '<i class="bi bi-arrow-left-right"></i> Switch to Tree View';
                  } else {
                      mobileChartCard.style.display = 'none';
                      treeCard.style.display = 'block';
                      this.innerHTML = '<i class="bi bi-arrow-left-right"></i> Switch to Visual View';
                  }
              });
          }

          // Chart container touch support
          var chartContainers = document.querySelectorAll('#chart-container, #mobile-chart-container');
          chartContainers.forEach(function(chartContainer) {
              if (chartContainer) {
                  // Variables for touch handling
                  var touchStartX = 0;
                  var touchStartY = 0;
                  var scrollLeft = 0;
                  var scrollTop = 0;

                  // Touch start event
                  chartContainer.addEventListener('touchstart', function(e) {
                      touchStartX = e.touches[0].clientX;
                      touchStartY = e.touches[0].clientY;
                      scrollLeft = chartContainer.scrollLeft;
                      scrollTop = chartContainer.scrollTop;
                  });

                  // Touch move event for scrolling
                  chartContainer.addEventListener('touchmove', function(e) {
                      if (e.touches.length === 1) {
                          e.preventDefault();
                          var touchMoveX = e.touches[0].clientX;
                          var touchMoveY = e.touches[0].clientY;
                          chartContainer.scrollLeft = scrollLeft - (touchMoveX - touchStartX);
                          chartContainer.scrollTop = scrollTop - (touchMoveY - touchStartY);
                      }
                  });

                  // Add double tap to reset zoom
                  var lastTap = 0;
                  chartContainer.addEventListener('touchend', function(e) {
                      var currentTime = new Date().getTime();
                      var tapLength = currentTime - lastTap;
                      if (tapLength < 500 && tapLength > 0) {
                          // Double tap - reset zoom
                          chartContainer.style.transform = 'scale(1)';
                          chartContainer.style.transformOrigin = '0 0';
                      }
                      lastTap = currentTime;
                  });

                  // Add pinch zoom support
                  var initialDistance = 0;
                  var initialScale = 1;

                  chartContainer.addEventListener('touchstart', function(e) {
                      if (e.touches.length === 2) {
                          // Calculate initial distance between fingers
                          var dx = e.touches[0].clientX - e.touches[1].clientX;
                          var dy = e.touches[0].clientY - e.touches[1].clientY;
                          initialDistance = Math.sqrt(dx * dx + dy * dy);
                          initialScale = chartContainer.style.transform ?
                              parseFloat(chartContainer.style.transform.replace('scale(', '').replace(')', '')) : 1;
                      }
                  });

                  chartContainer.addEventListener('touchmove', function(e) {
                      if (e.touches.length === 2) {
                          e.preventDefault();
                          // Calculate current distance between fingers
                          var dx = e.touches[0].clientX - e.touches[1].clientX;
                          var dy = e.touches[0].clientY - e.touches[1].clientY;
                          var currentDistance = Math.sqrt(dx * dx + dy * dy);

                          // Calculate scale
                          var scale = initialScale * (currentDistance / initialDistance);
                          scale = Math.min(Math.max(0.5, scale), 3); // Limit scale between 0.5 and 3

                          // Apply scale
                          chartContainer.style.transform = 'scale(' + scale + ')';
                          chartContainer.style.transformOrigin = '0 0';
                      }
                  });
              }
          });
      });
    </script>
@stop

@include('partials.mobile-footer')
