(function() {
  "use strict";

  const menuButton = document.getElementById("menu-button");
  const menuContainer = document.getElementById("menu-collapse");

  if (menuButton && menuContainer) {
    menuButton.addEventListener("click", toggleMenu);
  }

  /**
   * Toggle the open attribute on the menu container
   */
  function toggleMenu() {
    if (!menuContainer) {
      return;
    }

    if (menuContainer.hasAttribute("open")) {
      return menuContainer.removeAttribute("open");
    }
    return menuContainer.setAttribute("open", "true");
  }
}());
