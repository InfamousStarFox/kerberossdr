function ajaxpage(url, callback, arg){
  var page_request = false;

  // If Mozilla, Safari etc
  if (window.XMLHttpRequest){
    page_request = new XMLHttpRequest();
  }

  // If IE
  else if (window.ActiveXObject){
    try {
      page_request = new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch (e){
      try {
        page_request = new ActiveXObject("Microsoft.XMLHTTP");
      }
      catch (e){}
    }
  }

  // Else not suported
  else {
    return false;
  }

  page_request.onreadystatechange=function(){
    callback(page_request, arg);
  }
  page_request.open('GET', url, true);
  page_request.send(null);
}

function ajax_page_refresh(url, containerid) {
  ajaxpage(url, loadpage, containerid);
  setTimeout(function(){
      ajax_page_refresh(url, containerid);
    }, 500);

  function loadpage(page_request, containerid){
      if (page_request.readyState == 4 && (page_request.status==200 || window.location.href.indexOf("http")==-1)){
          document.getElementById(containerid).innerHTML=page_request.responseText;
      }
  }
}
