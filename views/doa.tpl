<html>
<head>
  <meta content="width=device-width, initial-scale=1" name="viewport" />
  <meta http-equiv="Cache-control" content="no-cache" charset="utf-8">
  <link rel="stylesheet" type="text/css" href="static/style.css">
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
  <div class="header">
    <a class="header_init" href="/init">Configuration and Spectrum</a> |
    <a class="header_sync" href="/sync">Sync</a> |
    <a class="header_doa" id="active" href="/doa">DOA Estimation</a> |
    <a class="header_pr" href="/pr">Passive Radar</a>
  </div>


  <div class="card">
    <div class="field">
      <h2>Antenna Configuration</h2>
    </div>
    <form action="/doa" method="post">
      <input type="hidden" name="ant_config" value="ant_config" />

      <div class="field">
        <div class="field-label">
          <label for="ant_arrangement">Arrangement:</label>
        </div>
        <div class="field-body">
          <select id="ant_arrangement" onChange="check_uca();" name = "ant_arrangement">
            <option value="0" {{!'selected="selected"' if ant_arrangement_index == 0 else ""}}>ULA</option>
            <option value="1" {{!'selected="selected"' if ant_arrangement_index == 1 else ""}}>UCA</option>
          </select>
        </div>
      </div>

      <div class="field">
        <div class="field-label">
          <label for="ant_spacing">Spacing [meters]:</label>
        </div>
        <div class="field-body">
          <input id="inputMeters" type="number" value="{{ant_meters}}" step="0.0001" name="ant_spacing" oninput="from_meters(this.value)"/>
        </div>
        <div class="field-label">
          <label for="ant_spacing">Spacing [feet]:</label>
        </div>
        <div class="field-body">
          <input id="inputFeet" type="number" step="0.0001" oninput="from_feet(this.value)" placeholder="Feet"/>
        </div>
        <div class="field-label">
          <label for="ant_spacing">Spacing [inches]:</label>
        </div>
        <div class="field-body">
          <input id="inputInches" type="number" step="0.0001" oninput="from_inches(this.value)" placeholder="Inches"/>
        </div>
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
      </div>

      <div class="field">
        Recommended Spacing:
        <table class="table">
          <tr>
            <th>{{center_freq}} MHz</th>
            <th>Min</th>
            <th>Max</th>
            <th>Best</th>
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
          </table>
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
        </div>

        <div class="field">
          <div class="field-label">
            <label for="en_doa">Enable DOA</label>
          </div>
          <div class="field-body">
            <input type="checkbox" name="en_doa" value="on" {{!'checked="checked"' if en_doa >= 1 else ""}}>
          </div>
        </div>

        <div class="field">
          <div class="field-label">
            <label for="doa_check">Algorithm</label>
          </div>
          <div class="field-body">
            <input class="doa_check" type="checkbox" name="en_bartlett" value="on" {{!'checked="checked"' if en_bartlett >= 1 else ""}}>Bartlett<br>
            <input class="doa_check" type="checkbox" name="en_capon" value="on" {{!'checked="checked"' if en_capon >= 1 else ""}}>Capon<br>
            <input class="doa_check" type="checkbox" name="en_MEM" value="on" {{!'checked="checked"' if en_MEM >= 1 else ""}}>MEM<br>
            <input class="doa_check" type="checkbox" name="en_MUSIC" value="on" {{!'checked="checked"' if en_MUSIC >= 1 else ""}}>MUSIC<br>
          </div>
        </div>

        <div class="field">
          <div class="field-label">
            <label for="en_fbavg">FB Average (Do not use with UCA)</label>
          </div>
          <div class="field-body">
            <input id="fb_avg" type="checkbox" name="en_fbavg" value="on" onChange="check_uca();" {{!'disabled' if ant_arrangement_index > 0 else ""}} {{!'checked="checked"' if en_fbavg >= 1 else ""}}>
          </div>
        </div>

        <div class="field">
          <input value="Update DOA" type="submit" class="btn" />
        </div>
      </form>
    </div>


    <div class="card">
      <canvas id="compass"></canvas>

      <div class="field">
        <div class="field-label">
          <label for="doa">Estimated DOA:</label>
        </div>
        <div class="field-body">
          <p id="doa"> 0 deg </p>
        </div>
        <div class="field-label">
          <label for="pwr">Signal Power:</label>
        </div>
        <div class="field-body">
          <p id="pwr"> 0 dB </p>
        </div>
        <div class="field-label">
          <label for="conf">DOA Confidence:</label>
        </div>
        <div class="field-body">
          <p id="conf"> 0 </p>
        </div>
      </div>

      <form onsubmit="setCookie()">
        <div class="field">
          <div class="field-label">
            <label for="MIN_PWR">Min Power</label>
          </div>
          <div class="field-body">
            <input type="number" class="input" step="0.01" min="0" value="0" max="100" name="MIN_PWR" id="MIN_PWR">
          </div>
        </div>
        <div class="field">
          <div class="field-label">
            <label for="MIN_CONF">Min Confidence</label>
          </div>
          <div class="field-body">
            <input type="number" class="input" step="1" min="0" value="0" max="100" name="MIN_CONF" id="MIN_CONF">
          </div>
        </div>
        <div class="field">
          <input value="Update Compass" type="submit" class="btn"/>
        </div>
      </form>
      <script type="text/javascript">init_compass();</script>
    </div>


    <div class="card">
      <div class="card-header">
        <canvas id="doa_graph"></canvas>
        <script type="text/javascript">init_graph('/static/images/doa.jpg', 'doa_graph');</script>
      </div>
      <div id="stats" style="text-align:center;"></div>
      <script type="text/javascript">ajax_page_refresh('/stats', 'stats');</script>
    </div>


    <div class="card">
      <div class="card-header">
        <div id="mapid" style="width: 100%; height: 400px;"></div>
        <script type='text/javascript'>init_map("{{center_freq}}");</script>
      </div>
      <p style="margin:0px; text-align:center;">Signal Direction</p>

      <form onsubmit="setCookie()">
        <div class="field">
          <div class="field-label">
            <label for="location">Auto Detect Location</label>
          </div>
          <div class="field-body">
            <input type="checkbox" name="location" value="on" checked="checked">
          </div>
        </div>
        <div class="field">
          <div class="field-label">
            <label for="offset">Set latitude</label>
          </div>
          <div class="field-body">
            <input type="number" class="input" step="0.0001" min="-90" value="0" max="90" name="offset">
          </div>
          <div class="field-label">
            <label for="offset">Set longitude</label>
          </div>
          <div class="field-body">
            <input type="number" class="input" step="0.0001" min="-180" value="0" max="80" name="offset">
          </div>
        </div>
        <div class="field">
          <div class="field-label">
            <label for="offset">Bearing offset (dgr)</label>
          </div>
          <div class="field-body">
            <input type="number" class="input" step="1" min="0" value="0" max="360" name="offset">
          </div>
        </div>
        <div class="field">
          <input value="Update Graph" type="submit" class="btn"/>
        </div>
      </form>

    </div>

  </body>
  </html>
