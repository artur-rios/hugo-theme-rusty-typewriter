(function() {
  "use strict";

  window.addEventListener("DOMContentLoaded", () => {
    const menu = document.getElementById("nav-dropdown-menu");
    const menu_btn = document.getElementById("nav-dropdown-button");
    menu_btn.addEventListener("click", e => {
      e.preventDefault();
      menu.classList.toggle("hidden");
    });

    var toggle_side_pane = e => {
      e.preventDefault();
      aside.classList.toggle("shown");
      overlay.classList.toggle("shown");
      aside_btn.classList.toggle("hidden");
      console.log("a");
    }

    const aside = document.getElementById("side-pane");
    const overlay = document.getElementById("aside-overlay");
    const aside_btn = document.getElementById("aside-toggle-button");
    aside_btn.addEventListener("click", toggle_side_pane);
    overlay.addEventListener("click", toggle_side_pane);

    window.addEventListener("hashchange", toggle_side_pane);
  });
})();
