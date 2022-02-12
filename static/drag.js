window.onload = function() {
  initDragElement();
  initResizeElement();
};

function placeOnTop(id){
            var elem = document.getElementById(id);
            var maxZ = Math.max.apply(null,
            $.map($('body *'), function(e,n) {
              if ($(e).css('position') != 'static')
                return parseInt($(e).css('z-index')) || 1;
            }));
            if (elem.style.zIndex != maxZ){
                elem.style.zIndex = maxZ + 1;
            }
        }

 function turnOffPointerEvents() {
        var popups = document.getElementsByTagName("iframe");
        console.log('in');

        for (var i = 0; i < popups.length; i++) {
            popups[i].style.pointerEvents = "none";
        };
  }

function turnOnPointerEvents() {
        var popups = document.getElementsByTagName("iframe");
        console.log('out');
        for (var i = 0; i < popups.length; i++) {
            popups[i].style.pointerEvents = "auto";
        };
  }

function initDragElement() {
  var pos1 = 0,
    pos2 = 0,
    pos3 = 0,
    pos4 = 0;
  var popups = document.getElementsByClassName("popup");
  var elmnt = null;
  var currentZIndex = 100; //TODO reset z index when a threshold is passed

  for (var i = 0; i < popups.length; i++) {
    var popup = popups[i];
    var header = getHeader(popup);

    popup.onmousedown = function() {
      placeOnTop(this.id);
    };

    if (header) {
      header.parentPopup = popup;
      header.onmousedown = dragMouseDown;
      header.onmouseup = turnOnPointerEvents;
    }
  }

  function dragMouseDown(e) {
    turnOffPointerEvents();
    elmnt = this.parentPopup;
    placeOnTop(elmnt.id);

    e = e || window.event;
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    if (!elmnt) {
      return;
    }

    e = e || window.event;
    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    // set the element's new position:
    elmnt.style.top = elmnt.offsetTop - pos2 + "px";
    elmnt.style.left = elmnt.offsetLeft - pos1 + "px";
  }

  function closeDragElement() {
    /* stop moving when mouse button is released:*/
    document.onmouseup = null;
    document.onmousemove = null;
  }

  function getHeader(element) {
    var headerItems = element.getElementsByClassName("popup-header");

    if (headerItems.length === 1) {
      return headerItems[0];
    }

    return null;
  }
}

function initResizeElement() {
  var popups = document.getElementsByClassName("popup");
  var element = null;
  var startX, startY, startWidth, startHeight;

  for (var i = 0; i < popups.length; i++) {
    var p = popups[i];

    var right = document.createElement("div");
    right.className = "resizer-right";
    right.onclick = turnOnPointerEvents;
    p.appendChild(right);
    right.addEventListener("mousedown", initDrag, false);
    right.parentPopup = p;
  }

  function initDrag(e) {
    element = this.parentPopup;

    console.log('turn-off');
    turnOffPointerEvents();

    startX = e.clientX;
    startY = e.clientY;
    startWidth = parseInt(
      document.defaultView.getComputedStyle(element).width,
      10
    );
    startHeight = parseInt(
      document.defaultView.getComputedStyle(element).height,
      10
    );
    document.documentElement.addEventListener("mousemove", doDrag, false);
    document.documentElement.addEventListener("mouseup", stopDrag, false);
  }

  function doDrag(e) {
    element.style.width = startWidth + e.clientX - startX + "px";
    element.style.height = startHeight + e.clientY - startY + "px";
  }

  function stopDrag() {
    turnOnPointerEvents();
    document.documentElement.removeEventListener("mousemove", doDrag, false);
    document.documentElement.removeEventListener("mouseup", stopDrag, false);
  }



}


