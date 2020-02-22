<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>KerberosSDR</title>

  <link href="/static/lib/bootstrap/bootstrap.min.css" rel="stylesheet">
  <link href="/static/style.css" rel="stylesheet">
  <link rel="stylesheet" href="static/lib/leaflet/leaflet.css"/>

  <script type='text/javascript' src="static/lib/leaflet/leaflet.js"></script>
  <script>
  function check_uca() {
    sel = document.getElementById("ant_arrangement")
    var x = sel.options[sel.selectedIndex].text;
    if (x == "UCA"){
      document.getElementById("fb_avg").disabled=true;
      document.getElementById("fb_avg").checked = false;
    }
    else {
      document.getElementById("fb_avg").removeAttribute("disabled");
    }
  }
  </script>
  <script type="text/javascript" src='/static/js/parseXML.js'></script>
  <script type="text/javascript" src='/static/js/compass.js'></script>
  <script type="text/javascript" src="/static/js/ajaxpage.js"></script>
  <script type="text/javascript" src="/static/js/graph.js"></script>
  <script type='text/javascript' src="/static/js/map_draw.js"></script>
  <script type='text/javascript' src="/static/js/unit_convert.js"></script>

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
          <li class="nav-item active">
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
          <h6 class="font-weight-bold">Antenna Configuration</h6>
        </div>
        <div class="card-body">

          <form action="/doa" method="post">
            <div class="form-group">
              <input type="hidden" name="ant_config" value="ant_config" />
              <label for="ant_arrangement">Arrangement:</label>
              <select class="form-control" id="ant_arrangement" onChange="check_uca();" name="ant_arrangement">
                <option value="0" {{!'selected="selected"' if ant_arrangement_index == 0 else ""}}>ULA</option>
                <option value="1" {{!'selected="selected"' if ant_arrangement_index == 1 else ""}}>UCA</option>
              </select>
            </div>

            <div class="form-group">
              Spacing:
              <div class="form-row">
                <div class="col-4">
                  <label for="ant_spacing">[meters]</label>
                  <input class="form-control" id="inputMeters" type="number" value="{{ant_meters}}" step="0.0001" name="ant_spacing" oninput="from_meters(this.value)"/>
                </div>
                <div class="col-4">
                  <label for="ant_spacing">[feet]</label>
                  <input class="form-control" id="inputFeet" type="number" step="0.0001" oninput="from_feet(this.value)" placeholder="Feet"/>
                </div>
                <div class="col-4">
                  <label for="ant_spacing">[inches]</label>
                  <input class="form-control" id="inputInches" type="number" step="0.0001" oninput="from_inches(this.value)" placeholder="Inches"/>
                </div>
              </div>
            </div>

            <div class="form-group">
              Recommended UCA Spacing:
              <table class="table table-striped">
                <thead class="thead-dark">
                  <tr>
                    <th>{{center_freq}} MHz</th>
                    <th>Min</th>
                    <th>Max</th>
                    <th>Best</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>Meters</td>
                    <td><span id="meter_min"></span></td>
                    <td><span id="meter_max"></span></td>
                    <td><span id="meter_best"></span></td>
                  </tr>
                  <tr>
                    <td>Feet</td>
                    <td><span id="feet_min"></span></td>
                    <td><span id="feet_max"></span></td>
                    <td><span id="feet_best"></span></td>
                  </tr>
                  <tr>
                    <td>Inches</td>
                    <td><span id="inches_min"></span></td>
                    <td><span id="inches_max"></span></td>
                    <td><span id="inches_best"></span></td>
                  </tr>
                </tbody>
              </table>
            </div>

            <div class="form-group">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="en_doa" value="on" {{!'checked="checked"' if en_doa >= 1 else ""}}>
                <label class="form-check-label" for="en_doa">Enable DOA</label>
              </div>
            </div>

            <div class="form-group">
              <label for="doa_check">Algorithm</label>
              <div class="ml-3">
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="en_bartlett" value="on" {{!'checked="checked"' if en_bartlett >= 1 else ""}}>
                  <label class="form-check-label" for="en_bartlett">Bartlett</label>
                </div>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="en_capon" value="on" {{!'checked="checked"' if en_capon >= 1 else ""}}>
                  <label class="form-check-label" for="en_capon">Capon</label>
                </div>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="en_MEM" value="on" {{!'checked="checked"' if en_MEM >= 1 else ""}}>
                  <label class="form-check-label" for="en_MEM">MEM</label>
                </div>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="en_MUSIC" value="on" {{!'checked="checked"' if en_MUSIC >= 1 else ""}}>
                  <label class="form-check-label" for="en_MUSIC">MUSIC</label>
                </div>
              </div>
            </div>

            <div class="form-group">
              <div class="form-check">
                <input class="form-check-input" id="fb_avg" type="checkbox" name="en_fbavg" value="on" onChange="check_uca();" {{!'disabled' if ant_arrangement_index > 0 else ""}} {{!'checked="checked"' if en_fbavg >= 1 else ""}}>
                <label class="form-check-label" for="en_fbavg">FB Average (Do not use with UCA)</label>
              </div>
            </div>

            <div class="form-group">
              <input value="Update DOA" type="submit" class="btn btn-secondary w-100" />
            </div>
          </form>
        </div>
      </div>

      <div class="card shadow">
        <div class="card-header">
          <h6 class="font-weight-bold">Compass</h6>
        </div>
        <div class="card-body">
          <canvas id="compass" class="card-img-top"></canvas>

          <div class="form-group">
            <div class="form-row">
              <label class="col-6 mb-0" for="doa">Estimated DOA:</label>
              <p class="col-6 mb-0" id="doa"> 0 deg </p>
            </div>
            <div class="form-row">
              <label class="col-6 mb-0" for="pwr">Signal Power:</label>
              <p class="col-6 mb-0" id="pwr"> 0 dB </p>
            </div>
            <div class="form-row">
              <label class="col-6 mb-0" for="conf">DOA Confidence:</label>
              <p class="col-6 mb-0" id="conf"> 0 </p>
            </div>
          </div>

          <form onsubmit="setCookie()">
            <div class="form-group">
              <div class="form-row">
                <div class="col-6">
                  <label for="MIN_PWR">Min Signal Power</label>
                  <input class="form-control" type="number" class="input" step="0.01" min="0" value="0" max="100" name="MIN_PWR" id="MIN_PWR">
                </div>
                <div class="col-6">
                  <label for="MIN_CONF">Min DOA Confidence</label>
                  <input class="form-control" type="number" class="input" step="1" min="0" value="0" max="100" name="MIN_CONF" id="MIN_CONF">
                </div>
              </div>
            </div>
            <div class="form-group">
              <input value="Update Compass" type="submit" class="btn btn-secondary w-100"/>
            </div>
          </form>
          <script type="text/javascript">init_compass();</script>
        </div>
      </div>

      <div class="card shadow">
        <div class="card-header">
          <h6 class="font-weight-bold">DOA Graph</h6>
        </div>
        <canvas id="doa_graph" class="card-img-top"></canvas>
        <div class="card-body">
          <script type="text/javascript">init_graph('/static/images/doa.jpg', 'doa_graph');</script>
          <div id="stats" style="text-align:center;"></div>
          <script type="text/javascript">ajax_page_refresh('/stats', 'stats');</script>
        </div>
      </div>

      <div class="card shadow">
        <div class="card-header">
          <h6 class="font-weight-bold">Signal Direction Map</h6>
        </div>
        <div id="mapid" style="width: 100%; height: 400px;" class="card-img-top"></div>
        <div class="card-body">
          <script type='text/javascript'>init_map("{{center_freq}}");</script>

          <form onsubmit="setCookie()">
            <div class="form-group">
              <label for="location">Location</label>
              <div class="ml-3">
                <div class="form-check">
                  <input class="form-check-input" type="radio" name="location" id="location_auto" value="location_auto" checked="checked">
                  <label class="form-check-label" for="location_auto">Auto Detect</label>
                </div>
                <div class="form-check">
                  <input class="form-check-input" type="radio" name="location" id="location_manual" value="location_manual" checked="checked">
                  <label class="form-check-label" for="location_manual">Manual</label>
                </div>
              </div>
            </div>
            <div class="form-group">
              <div class="form-row">
                <div class="col-6">
                  <label for="offset">Set latitude</label>
                  <input class="form-control" type="number" class="input" step="0.0001" min="-90" value="0" max="90" name="offset">
                </div>
                <div class="col-6">
                  <label for="offset">Set longitude</label>
                  <input class="form-control" type="number" class="input" step="0.0001" min="-180" value="0" max="80" name="offset">
                </div>
              </div>
            </div>
            <div class="form-group">
              <label for="offset">Heading (dgr)</label>
              <input class="form-control" type="number" class="input" step="1" min="0" value="0" max="360" name="heading">
            </div>
            <div class="form-group">
              <label for="offset">Bearing offset (dgr)</label>
              <input class="form-control" type="number" class="input" step="1" min="0" value="0" max="360" name="offset">
            </div>
            <div class="form-group">
              <input value="Update Graph" type="submit" class="btn btn-secondary w-100"/>
            </div>
          </form>
        </div>
      </div>

    </div>
  </div>

  <script type="text/javascript">
  document.getElementById("meter_min").innerHTML = (mhz_to_meters({{center_freq}})/10).toFixed(4);
  document.getElementById("meter_max").innerHTML = (mhz_to_meters({{center_freq}})/2).toFixed(4);
  document.getElementById("meter_best").innerHTML = (mhz_to_meters({{center_freq}})/3).toFixed(4);
  document.getElementById("feet_min").innerHTML = (mhz_to_feet({{center_freq}})/10).toFixed(4);
  document.getElementById("feet_max").innerHTML = (mhz_to_feet({{center_freq}})/2).toFixed(4);
  document.getElementById("feet_best").innerHTML = (mhz_to_feet({{center_freq}})/3).toFixed(4);
  document.getElementById("inches_min").innerHTML = (mhz_to_inches({{center_freq}})/10).toFixed(4);
  document.getElementById("inches_max").innerHTML = (mhz_to_inches({{center_freq}})/2).toFixed(4);
  document.getElementById("inches_best").innerHTML = (mhz_to_inches({{center_freq}})/3).toFixed(4);
  </script>
  <script type="text/javascript">
  function from_meters(valNum) {
    document.getElementById("inputFeet").value=meters_to_feet(valNum);
    document.getElementById("inputInches").value=meters_to_inches(valNum);
  }
  function from_feet(valNum) {
    document.getElementById("inputMeters").value=feet_to_meters(valNum);
    document.getElementById("inputInches").value=feet_to_inches(valNum);
  }
  function from_inches(valNum) {
    document.getElementById("inputMeters").value=inches_to_meters(valNum);
    document.getElementById("inputFeet").value=inches_to_feet(valNum);
  }
  </script>

  <script src="/static/lib/bootstrap/jquery-1.12.4.min.js"></script>
  <script src="/static/lib/bootstrap/bootstrap.min.js"></script>

</body>
</html>
