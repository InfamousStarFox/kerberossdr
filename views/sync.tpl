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
          <li class="nav-item active">
            <a class="nav-link" href="/sync">Sync</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/doa">DOA Estimation</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/pr">Passive Radar</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <br>

  <div class="container">
    <div class="card-columns">

      <div class="card shadow">
        <div class="card-header">
          <h6 class="font-weight-bold" id="rx_sync_title">Receiver Synchronization</h6>
        </div>
        <div class="card-body">
          <form action="/sync" method="post">
            <div class="form-group">
              <input type="hidden" name="enable_all_sync" value="enable_all_sync" />
              <input id="set_cal_all" type="submit" value="{{!"Disable" if en_sync >= 1 or en_noise >= 1 else "Enable"}} Noise Source & Sync Display" class="btn btn-secondary w-100">
            </div>
          </form>
          <form action="/sync" method="post">
            <div class="form-group">
              <input type="hidden" name="update_sync" value="update_sync" />
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="en_sync" value="on" {{!'checked="checked"' if en_sync >= 1 else ""}}>
                <label class="form-check-label" for="en_sync">Enable Sync Display</label>
              </div>
            </div>
            <div class="form-group">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="" value="on" {{!'checked="checked"' if en_noise >= 1 else ""}}>
                <label class="form-check-label" for="en_noise">Noise Source ON/OFF</label>
              </div>
            </div>
            <div class="form-group">
              <input value="Update" type="submit" class="btn btn-secondary w-100" />
            </div>
          </form>

          <br><hr><br>

          <form action="/sync" method="post">
            <div class="form-group">
              <input type="hidden" name="del_hist" value="del_hist" />
              <input value="Delete History" type="submit" class="btn btn-secondary w-100">
            </div>
          </form>
          <form action="/sync" method="post">
            <div class="form-group">
              <input type="hidden" name="samp_sync" value="samp_sync" />
              <input value="Sample Sync" type="submit" class="btn btn-secondary w-100">
            </div>
          </form>
          <form action="/sync" method="post">
            <div class="form-group">
              <input type="hidden" name="cal_iq" value="cal_iq" />
              <input value="Calibrate IQ" type="submit" class="btn btn-secondary w-100">
            </div>
          </form>

        </div>
      </div>

      <div class="card shadow">
        <div class="card-header">
          <h6 class="font-weight-bold">Sync Graph</h6>
        </div>
        <canvas id="sync" class="card-img-top"></canvas>
        <div class="card-body">
          <script type="text/javascript">init_graph('/static/images/sync.jpg', 'sync');</script>
          <div id="stats" style="text-align:center;"></div>
          <script type="text/javascript">ajax_page_refresh('/stats', 'stats');</script>
        </div>
      </div>
    </div>

  </div>
</div>

<script src="/static/lib/bootstrap/jquery-1.12.4.min.js"></script>
<script src="/static/lib/bootstrap/bootstrap.min.js"></script>

</body>
</html>
