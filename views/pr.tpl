<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>KerberosSDR</title>

  <link href="/static/lib/bootstrap/bootstrap.min.css" rel="stylesheet">
  <link href="/static/style.css" rel="stylesheet">
  <script type="text/javascript" src="/static/js/ajaxpage.js"></script>
  <script type="text/javascript" src="static/js/graph.js"></script>
</head>
<body>

  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <h1 class="navbar-brand mb-0">KerberosSDR</h1>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mx-auto">
          <li class="nav-item">
            <a class="nav-link" href="/init">Configuration and Spectrum</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/sync">Sync</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/doa">DOA Estimation</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="/pr">Passive Radar</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <br>

  <form action="/pr" method="post">
    <div class="container">
      <div class="card-columns">

        <div class="card shadow">
          <div class="card-header">
            <h6 class="font-weight-bold">Channel Configuration</h6>
          </div>
          <div class="card-body">
            <div class="form-group">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="en_pr" value="on" {{!'checked="checked"' if en_pr >= 1 else ""}}>
                <label class="form-check-label" for="en_pr">Enable Passive Radar Processing</label>
              </div>
            </div>
            <div class="form-group">
              <label for="ref_ch">Reference Channel [0-3]:</label>
              <input class="form-control" type="number" value="{{ref_ch}}" step="1" name="ref_ch"/>
            </div>
            <div class="form-group">
              <label for="surv_ch">Suveillance Channel [0-3]:</label>
              <input class="form-control" type="number" value="{{surv_ch}}" step="1" name="surv_ch"/>
            </div>
          </div>
        </div>

        <div class="card shadow">
          <div class="card-header">
            <h6 class="font-weight-bold">Time domain clutter cancellation</h6>
          </div>
          <div class="card-body">
            <div class="form-group">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="en_clutter" value="on" {{!'checked="checked"' if en_clutter >= 1 else ""}}>
                <label class="form-check-label" for="en_clutter">Enable/Disable</label>
              </div>
            </div>
            <div class="form-group">
              <label for="filt_dim">Filter Dimension:</label>
              <input class="form-control" type="number" value="{{filt_dim}}" step="1" name="filt_dim"/>
            </div>
          </div>
        </div>

        <div class="card shadow">
          <div class="card-header">
            <h6 class="font-weight-bold">Cross-Correlation Detector</h6>
          </div>
          <div class="card-body">
            <div class="form-group">
              <label for="max_range">Max Range  (Must be power of 2):</label>
              <input class="form-control" type="number" value="{{max_range}}" step="1" name="max_range"/>
            </div>
            <div class="form-group">
              <label for="max_doppler">Max Doppler:</label>
              <input class="form-control" type="number" value="{{max_doppler}}" step="1" name="max_doppler"/>
            </div>
            <div class="form-group">
              <label for="windowing_mode">Windowing:</label>
              <select class="form-control" id="windowing_mode" name="windowing_mode">
                <option value="0" {{!'selected="selected"' if windowing_mode == 0 else ""}}>Rectangular</option>
                <option value="1" {{!'selected="selected"' if windowing_mode == 1 else ""}}>Hamming</option>
              </select>
            </div>
            <div class="form-group">
              <label for="dyn_range">Dynamic Range</label>
              <input class="form-control" type="number" value="{{dyn_range}}" step="1" name="dyn_range"/>
            </div>
          </div>
        </div>

        <div class="card shadow">
          <div class="card-header">
            <h6 class="font-weight-bold">Automatic Detection (CA-CFAR)</h6>
          </div>
          <div class="card-body">
            <div class="form-group">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="en_det" value="on" {{!'checked="checked"' if en_det >= 1 else ""}}>
                <label class="form-check-label" for="en_det">Enable/Disable</label>
              </div>
            </div>
            <div class="form-group">
              <label for="est_win">Estimation Window</label>
              <input class="form-control" type="number" value="{{est_win}}" step="1" name="est_win"/>
            </div>
            <div class="form-group">
              <label for="guard_win">Guard Window</label>
              <input class="form-control" type="number" value="{{guard_win}}" step="1" name="guard_win"/>
            </div>
            <div class="form-group">
              <label for="thresh_det">Threshold [dB]</label>
              <input class="form-control" type="number" value="{{thresh_det}}" step="0.01" name="thresh_det"/>
            </div>
          </div>
        </div>

        <div class="card shadow">
          <div class="card-header">
            <h6 class="font-weight-bold">Other Settings</h6>
          </div>
          <div class="card-body">
            <div class="form-group">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="en_peakhold" value="on" {{!'checked="checked"' if en_peakhold >= 1 else ""}}>
                <label class="form-check-label" for="en_peakhold">Enable Peak Hold</label>
              </div>
            </div>
            <div class="form-group">
              <input value="Update Paramaters" type="submit" class="btn btn-secondary w-100"/>
            </div>
          </div>
        </div>

        <div class="card shadow">
          <div class="card-header">
            <h6 class="font-weight-bold">Graph</h6>
          </div>
          <canvas id="pr_graph" class="card-img-top"></canvas>
          <div class="card-body">
            <script type="text/javascript">init_graph('/static/images/pr.jpg', 'pr_graph');</script>
            <div id="stats" style="text-align:center;"></div>
            <script type="text/javascript">ajax_page_refresh('/stats', 'stats');</script>
          </div>
        </div>

      </div>
    </div>
  </form>

  <script src="/static/lib/bootstrap/jquery-1.12.4.min.js"></script>
  <script src="/static/lib/bootstrap/bootstrap.min.js"></script>

</body>
</html>
