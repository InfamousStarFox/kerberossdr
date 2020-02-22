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
  <script>
  function check_check_box() {
    var elms = document.getElementsByClassName('disable')
    if (document.getElementById("uniform_gain_id").checked) {
      for (var i = 0; i < elms.length; i++) {
        elms[i].disabled=true;
      }
    }
    else {
      for (var i = 0; i < elms.length; i++) {
        elms[i].removeAttribute("disabled");
      }
    }
  }
  </script>
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
          <li class="nav-item active">
            <a class="nav-link" href="/init">Configuration and Spectrum</a>
          </li>
          <li class="nav-item">
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
          <h6 class="font-weight-bold" id="init_title">Receiver Configuration</h6>
        </div>
        <div class="card-body">
          <form action="/init" method="post">
            <div class="form-group">
              <input type="hidden" name="rcv_params" value="rcv_params" />
              <label for="center_freq">Center Frequency [MHz]:</label>
              <input class="form-control" type="number" value="{{center_freq}}" min="24" max="1700" step="0.0001" name="center_freq"/>
            </div>
            <div class="form-group">
              <label for="samp_freq">Sampling Freq [MHz]:</label>
              <select class="form-control" id="samp_freq" name="samp_freq">
                <option value="0" {{!'selected="selected"' if samp_index == 0 else ""}}>0.25</option>
                <option value="1" {{!'selected="selected"' if samp_index == 1 else ""}}>0.900001</option>
                <option value="2" {{!'selected="selected"' if samp_index == 2 else ""}}>1.024</option>
                <option value="3" {{!'selected="selected"' if samp_index == 3 else ""}}>1.4</option>
                <option value="4" {{!'selected="selected"' if samp_index == 4 else ""}}> 1.8</option>
                <option value="5" {{!'selected="selected"' if samp_index == 5 else ""}}>1.92</option>
                <option value="6" {{!'selected="selected"' if samp_index == 6 else ""}}>2.048</option>
                <option value="7" {{!'selected="selected"' if samp_index == 7 else ""}}>2.4</option>
                <option value="8" {{!'selected="selected"' if samp_index == 8 else ""}}>2.56</option>
              </select>
            </div>
            <div class="form-group">
              <div class="form-check">
                <input class="form-check-input" id="uniform_gain_id" type="checkbox" name="uniform_gain" value="on" onclick="check_check_box()" {{!'checked="checked"' if uniform_gain >= 1 else ""}}>
                <label class="form-check-label" for="uniform_gain">Uniform Gain</label>
              </div>
            </div>
            <div class="form-group">
              <label for="gain">RX1 Gain [dB]:</label>
              <select class="form-control" id="gain" name="gain">
                <option value="0" {{!'selected="selected"' if gain_index == 0 else ""}}>0</option>
                <option value="1" {{!'selected="selected"' if gain_index == 1 else ""}}>0.9</option>
                <option value="2" {{!'selected="selected"' if gain_index == 2 else ""}}>1.4</option>
                <option value="3" {{!'selected="selected"' if gain_index == 3 else ""}}>2.7</option>
                <option value="4" {{!'selected="selected"' if gain_index == 4 else ""}}>3.7</option>
                <option value="5" {{!'selected="selected"' if gain_index == 5 else ""}}>7.7</option>
                <option value="6" {{!'selected="selected"' if gain_index == 6 else ""}}>8.7</option>
                <option value="7" {{!'selected="selected"' if gain_index == 7 else ""}}>12.5</option>
                <option value="8" {{!'selected="selected"' if gain_index == 8 else ""}}>14.4</option>
                <option value="9" {{!'selected="selected"' if gain_index == 9 else ""}}>15.7</option>
                <option value="10" {{!'selected="selected"' if gain_index == 10 else ""}}>16.6</option>
                <option value="11" {{!'selected="selected"' if gain_index == 11 else ""}}>19.7</option>
                <option value="12" {{!'selected="selected"' if gain_index == 12 else ""}}>20.7</option>
                <option value="13" {{!'selected="selected"' if gain_index == 13 else ""}}>22.9</option>
                <option value="14" {{!'selected="selected"' if gain_index == 14 else ""}}>25.4</option>
                <option value="15" {{!'selected="selected"' if gain_index == 15 else ""}}>28.0</option>
                <option value="16" {{!'selected="selected"' if gain_index == 16 else ""}}>29.7</option>
                <option value="17" {{!'selected="selected"' if gain_index == 17 else ""}}>32.8</option>
                <option value="18" {{!'selected="selected"' if gain_index == 18 else ""}}>33.8</option>
                <option value="19" {{!'selected="selected"' if gain_index == 19 else ""}}>36.4</option>
                <option value="20" {{!'selected="selected"' if gain_index == 20 else ""}}>37.2</option>
                <option value="21" {{!'selected="selected"' if gain_index == 21 else ""}}>38.6</option>
                <option value="22" {{!'selected="selected"' if gain_index == 22 else ""}}>40.2</option>
                <option value="23" {{!'selected="selected"' if gain_index == 23 else ""}}>42.1</option>
                <option value="24" {{!'selected="selected"' if gain_index == 24 else ""}}>43.4</option>
                <option value="25" {{!'selected="selected"' if gain_index == 25 else ""}}>43.9</option>
                <option value="26" {{!'selected="selected"' if gain_index == 26 else ""}}>44.5</option>
                <option value="27" {{!'selected="selected"' if gain_index == 27 else ""}}>48.0</option>
                <option value="28" {{!'selected="selected"' if gain_index == 28 else ""}}>49.6</option>
              </select>
            </div>
            <div class="form-group">
              <label for="gain_2">RX2 Gain [dB]:</label>
              <select class="form-control disable" {{!'disabled' if uniform_gain >= 1 else ""}} id="gain_2" name="gain_2">
                <option value="0" {{!'selected="selected"' if gain_index_2 == 0 else ""}}>0</option>
                <option value="1" {{!'selected="selected"' if gain_index_2 == 1 else ""}}>0.9</option>
                <option value="2" {{!'selected="selected"' if gain_index_2 == 2 else ""}}>1.4</option>
                <option value="3" {{!'selected="selected"' if gain_index_2 == 3 else ""}}>2.7</option>
                <option value="4" {{!'selected="selected"' if gain_index_2 == 4 else ""}}>3.7</option>
                <option value="5" {{!'selected="selected"' if gain_index_2 == 5 else ""}}>7.7</option>
                <option value="6" {{!'selected="selected"' if gain_index_2 == 6 else ""}}>8.7</option>
                <option value="7" {{!'selected="selected"' if gain_index_2 == 7 else ""}}>12.5</option>
                <option value="8" {{!'selected="selected"' if gain_index_2 == 8 else ""}}>14.4</option>
                <option value="9" {{!'selected="selected"' if gain_index_2 == 9 else ""}}>15.7</option>
                <option value="10" {{!'selected="selected"' if gain_index_2 == 10 else ""}}>16.6</option>
                <option value="11" {{!'selected="selected"' if gain_index_2 == 11 else ""}}>19.7</option>
                <option value="12" {{!'selected="selected"' if gain_index_2 == 12 else ""}}>20.7</option>
                <option value="13" {{!'selected="selected"' if gain_index_2 == 13 else ""}}>22.9</option>
                <option value="14" {{!'selected="selected"' if gain_index_2 == 14 else ""}}>25.4</option>
                <option value="15" {{!'selected="selected"' if gain_index_2 == 15 else ""}}>28.0</option>
                <option value="16" {{!'selected="selected"' if gain_index_2 == 16 else ""}}>29.7</option>
                <option value="17" {{!'selected="selected"' if gain_index_2 == 17 else ""}}>32.8</option>
                <option value="18" {{!'selected="selected"' if gain_index_2 == 18 else ""}}>33.8</option>
                <option value="19" {{!'selected="selected"' if gain_index_2 == 19 else ""}}>36.4</option>
                <option value="20" {{!'selected="selected"' if gain_index_2 == 20 else ""}}>37.2</option>
                <option value="21" {{!'selected="selected"' if gain_index_2 == 21 else ""}}>38.6</option>
                <option value="22" {{!'selected="selected"' if gain_index_2 == 22 else ""}}>40.2</option>
                <option value="23" {{!'selected="selected"' if gain_index_2 == 23 else ""}}>42.1</option>
                <option value="24" {{!'selected="selected"' if gain_index_2 == 24 else ""}}>43.4</option>
                <option value="25" {{!'selected="selected"' if gain_index_2 == 25 else ""}}>43.9</option>
                <option value="26" {{!'selected="selected"' if gain_index_2 == 26 else ""}}>44.5</option>
                <option value="27" {{!'selected="selected"' if gain_index_2 == 27 else ""}}>48.0</option>
                <option value="28" {{!'selected="selected"' if gain_index_2 == 28 else ""}}>49.6</option>
              </select>
            </div>
            <div class="form-group">
              <label for="gain_3">RX3 Gain [dB]:</label>
              <select class="form-control disable" {{!'disabled' if uniform_gain >= 1 else ""}} id="gain_3" name="gain_3">
                <option value="0" {{!'selected="selected"' if gain_index_3 == 0 else ""}}>0</option>
                <option value="1" {{!'selected="selected"' if gain_index_3 == 1 else ""}}>0.9</option>
                <option value="2" {{!'selected="selected"' if gain_index_3 == 2 else ""}}>1.4</option>
                <option value="3" {{!'selected="selected"' if gain_index_3 == 3 else ""}}>2.7</option>
                <option value="4" {{!'selected="selected"' if gain_index_3 == 4 else ""}}>3.7</option>
                <option value="5" {{!'selected="selected"' if gain_index_3 == 5 else ""}}>7.7</option>
                <option value="6" {{!'selected="selected"' if gain_index_3 == 6 else ""}}>8.7</option>
                <option value="7" {{!'selected="selected"' if gain_index_3 == 7 else ""}}>12.5</option>
                <option value="8" {{!'selected="selected"' if gain_index_3 == 8 else ""}}>14.4</option>
                <option value="9" {{!'selected="selected"' if gain_index_3 == 9 else ""}}>15.7</option>
                <option value="10" {{!'selected="selected"' if gain_index_3 == 10 else ""}}>16.6</option>
                <option value="11" {{!'selected="selected"' if gain_index_3 == 11 else ""}}>19.7</option>
                <option value="12" {{!'selected="selected"' if gain_index_3 == 12 else ""}}>20.7</option>
                <option value="13" {{!'selected="selected"' if gain_index_3 == 13 else ""}}>22.9</option>
                <option value="14" {{!'selected="selected"' if gain_index_3 == 14 else ""}}>25.4</option>
                <option value="15" {{!'selected="selected"' if gain_index_3 == 15 else ""}}>28.0</option>
                <option value="16" {{!'selected="selected"' if gain_index_3 == 16 else ""}}>29.7</option>
                <option value="17" {{!'selected="selected"' if gain_index_3 == 17 else ""}}>32.8</option>
                <option value="18" {{!'selected="selected"' if gain_index_3 == 18 else ""}}>33.8</option>
                <option value="19" {{!'selected="selected"' if gain_index_3 == 19 else ""}}>36.4</option>
                <option value="20" {{!'selected="selected"' if gain_index_3 == 20 else ""}}>37.2</option>
                <option value="21" {{!'selected="selected"' if gain_index_3 == 21 else ""}}>38.6</option>
                <option value="22" {{!'selected="selected"' if gain_index_3 == 22 else ""}}>40.2</option>
                <option value="23" {{!'selected="selected"' if gain_index_3 == 23 else ""}}>42.1</option>
                <option value="24" {{!'selected="selected"' if gain_index_3 == 24 else ""}}>43.4</option>
                <option value="25" {{!'selected="selected"' if gain_index_3 == 25 else ""}}>43.9</option>
                <option value="26" {{!'selected="selected"' if gain_index_3 == 26 else ""}}>44.5</option>
                <option value="27" {{!'selected="selected"' if gain_index_3 == 27 else ""}}>48.0</option>
                <option value="28" {{!'selected="selected"' if gain_index_3 == 28 else ""}}>49.6</option>
              </select>
            </div>
            <div class="form-group">
              <label for="gain_4">RX4 Gain [dB]:</label>
              <select class="form-control disable" {{!'disabled' if uniform_gain >= 1 else ""}} id="gain_4" name="gain_4">
                <option value="0" {{!'selected="selected"' if gain_index_4 == 0 else ""}}>0</option>
                <option value="1" {{!'selected="selected"' if gain_index_4 == 1 else ""}}>0.9</option>
                <option value="2" {{!'selected="selected"' if gain_index_4 == 2 else ""}}>1.4</option>
                <option value="3" {{!'selected="selected"' if gain_index_4 == 3 else ""}}>2.7</option>
                <option value="4" {{!'selected="selected"' if gain_index_4 == 4 else ""}}>3.7</option>
                <option value="5" {{!'selected="selected"' if gain_index_4 == 5 else ""}}>7.7</option>
                <option value="6" {{!'selected="selected"' if gain_index_4 == 6 else ""}}>8.7</option>
                <option value="7" {{!'selected="selected"' if gain_index_4 == 7 else ""}}>12.5</option>
                <option value="8" {{!'selected="selected"' if gain_index_4 == 8 else ""}}>14.4</option>
                <option value="9" {{!'selected="selected"' if gain_index_4 == 9 else ""}}>15.7</option>
                <option value="10" {{!'selected="selected"' if gain_index_4 == 10 else ""}}>16.6</option>
                <option value="11" {{!'selected="selected"' if gain_index_4 == 11 else ""}}>19.7</option>
                <option value="12" {{!'selected="selected"' if gain_index_4 == 12 else ""}}>20.7</option>
                <option value="13" {{!'selected="selected"' if gain_index_4 == 13 else ""}}>22.9</option>
                <option value="14" {{!'selected="selected"' if gain_index_4 == 14 else ""}}>25.4</option>
                <option value="15" {{!'selected="selected"' if gain_index_4 == 15 else ""}}>28.0</option>
                <option value="16" {{!'selected="selected"' if gain_index_4 == 16 else ""}}>29.7</option>
                <option value="17" {{!'selected="selected"' if gain_index_4 == 17 else ""}}>32.8</option>
                <option value="18" {{!'selected="selected"' if gain_index_4 == 18 else ""}}>33.8</option>
                <option value="19" {{!'selected="selected"' if gain_index_4 == 19 else ""}}>36.4</option>
                <option value="20" {{!'selected="selected"' if gain_index_4 == 20 else ""}}>37.2</option>
                <option value="21" {{!'selected="selected"' if gain_index_4 == 21 else ""}}>38.6</option>
                <option value="22" {{!'selected="selected"' if gain_index_4 == 22 else ""}}>40.2</option>
                <option value="23" {{!'selected="selected"' if gain_index_4 == 23 else ""}}>42.1</option>
                <option value="24" {{!'selected="selected"' if gain_index_4 == 24 else ""}}>43.4</option>
                <option value="25" {{!'selected="selected"' if gain_index_4 == 25 else ""}}>43.9</option>
                <option value="26" {{!'selected="selected"' if gain_index_4 == 26 else ""}}>44.5</option>
                <option value="27" {{!'selected="selected"' if gain_index_4 == 27 else ""}}>48.0</option>
                <option value="28" {{!'selected="selected"' if gain_index_4 == 28 else ""}}>49.6</option>
              </select>
            </div>
            <div class="form-group">
              <input value="Update Receiver Paramaters" type="submit" class="btn btn-secondary w-100"/>
            </div>
          </form>
        </div>
      </div>

      <div class="card shadow">
        <div class="card-header">
          <h6 class="font-weight-bold" id="init_title">IQ Preprocessing</h6>
        </div>
        <div class="card-body">
          <form action="/init" method="post">
            <div class="form-group">
              <input type="hidden" name="iq_params" value="iq_params" />
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="dc_comp" value="on" {{!'checked="checked"' if dc_comp >= 1 else ""}}>
                <label class="form-check-label" for="dc_comp">DC Compensation</label>
              </div>
            </div>
            <div class="form-group">
              <label for="filt_bw">Filter BW [kHz]:</label>
              <input class="form-control" type="number" value="{{filt_bw}}" step="0.001" name="filt_bw"/>
            </div>
            <div class="form-group">
              <label for="filt_bw">FIR Tap Size:</label>
              <input class="form-control" type="number" value="{{fir_size}}" step="1" name="fir_size"/>
            </div>
            <div class="form-group">
              <label for="filt_bw">Decimation:</label>
              <input class="form-control" type="number" value="{{decimation}}" step="1" name="decimation"/>
            </div>
            <div class="form-group">
              <input value="Update IQ Paramaters" type="submit" class="btn btn-secondary w-100"/>
            </div>
          </form>
        </div>
      </div>

      <div class="card shadow">
        <div class="card-header">
          <h6 class="font-weight-bold">System Controls</h6>
        </div>
        <div class="card-body">
          <form action="/init" method="post">
            <div class="form-group">
              <input type="hidden" name="start" value="start" />
              <input value="Start Processing" type="submit" class="btn btn-secondary w-100"/>
            </div>
          </form>
          <form action="/init" method="post">
            <div class="form-group">
              <input type="hidden" name="stop" value="stop" />
              <input value="Stop Processing" type="submit" class="btn btn-secondary w-100"/>
            </div>
          </form>
          <form action="/init" method="post">
            <div class="form-group">
              <input type="hidden" name="reboot" value="reboot" />
              <input value="Reboot Software" type="submit" class="btn btn-secondary w-100"/>
            </div>
          </form>
        </div>
      </div>

      <div class="card shadow">
        <div class="card-header">
          <h6 class="font-weight-bold">Spectrum Controls</h6>
        </div>
        <div class="card-body">
          <form action="/init" method="post">
            <div class="form-group">
              <input type="hidden" name="start_spec" value="start_spec" />
              <input value="Start Spectrum Display" type="submit" class="btn btn-secondary w-100"/>
            </div>
          </form>
          <form action="/init" method="post">
            <div class="form-group">
              <input type="hidden" name="stop_spec" value="stop_spec" />
              <input value="Stop Spectrum Display" type="submit" class="btn btn-secondary w-100"/>
            </div>
          </form>
        </div>
      </div>

      <div class="card shadow">
        <div class="card-header">
          <h6 class="font-weight-bold">Spectrum Graph</h6>
        </div>
        <canvas id="spectrum" class="card-img-top"></canvas>
        <div class="card-body">
          <div id="stats" style="text-align:center;"></div>
          <script type="text/javascript">init_graph('/static/images/spectrum.jpg', 'spectrum');</script>
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
