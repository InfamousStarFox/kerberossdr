<html>
<head>
  <meta content="width=device-width, initial-scale=1" name="viewport" />
  <meta http-equiv="Cache-control" content="no-cache" charset="utf-8">
  <link rel="stylesheet" type="text/css" href="static/style.css">
  <script type="text/javascript" src="/static/js/ajaxpage.js"></script>
  <script type="text/javascript" src="static/js/graph.js"></script>
</head>
<body>

  <div class="header">
    <a class="header_init" href="/init">Configuration and Spectrum</a> |
    <a class="header_sync" id="active" href="/sync">Sync</a> |
    <a class="header_doa" href="/doa">DOA Estimation</a> |
    <a class="header_pr" href="/pr">Passive Radar</a>
  </div>


  <div class="card">
    <h2 id="rx_sync_title">Receiver Synchronization</h2>
    <form action="/sync" method="post">
      <input type="hidden" name="enable_all_sync" value="enable_all_sync" />
      <div class="field">
        <input id="set_cal_all" type="submit" value="{{!"Disable" if en_sync >= 1 or en_noise >= 1 else "Enable"}} Noise Source & Sync Display" class="btn">
      </div>
    </form>

    <form action="/sync" method="post">
      <input type="hidden" name="update_sync" value="update_sync" />
      <div class="field">
        <div class="field-label">
          <label for="en_sync">Enable Sync Display</label>
        </div>
        <div class="field-body">
          <input type="checkbox" name="en_sync" value="on" {{!'checked="checked"' if en_sync >= 1 else ""}}>
        </div>
      </div>

      <div class="field">
        <div class="field-label">
          <label for="en_noise">Noise Source ON/OFF</label>
        </div>
        <div class="field-body">
          <input type="checkbox" name="" value="on" {{!'checked="checked"' if en_noise >= 1 else ""}}>
        </div>
      </div>

      <div class="field">
        <input value="Update" type="submit" class="btn" />
      </div>
    </form>
  </div>

  <div class="card">
    <form action="/sync" method="post">
      <input type="hidden" name="del_hist" value="del_hist" />
      <div class="field">
        <input value="Delete History" type="submit" class="btn">
      </div>
    </form>

    <form action="/sync" method="post">
      <input type="hidden" name="samp_sync" value="samp_sync" />
      <div class="field">
        <input value="Sample Sync" type="submit" class="btn">
      </div>
    </form>

    <form action="/sync" method="post">
      <input type="hidden" name="cal_iq" value="cal_iq" />
      <div class="field">
        <input value="Calibrate IQ" type="submit" class="btn">
      </div>
    </form>
  </div>

  <div class="card">
    <div class="card-header">
      <canvas id="sync"></canvas>
      <script type="text/javascript">init_graph('/static/images/sync.jpg', 'sync');</script>
    </div>
    <div id="stats" style="text-align:center;"></div>
    <script type="text/javascript">ajax_page_refresh('/stats', 'stats');</script>
  </div>

</body>
</html>
