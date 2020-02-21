function init_graph(url, id) {
    var canvas = document.getElementById(id);
    var context = canvas.getContext("2d");
    var img = new Image();
    img.onload = function() {
        canvas.setAttribute("width", img.width)
        canvas.setAttribute("height", img.height)
        context.drawImage(this, 0, 0);
    };
    refresh_graph(url, img);
}
function refresh_graph(url, img) {
    img.src = url + "?t=" + new Date().getTime();
    setTimeout(function(){
        refresh_graph(url, img);
      }, 500);
}
