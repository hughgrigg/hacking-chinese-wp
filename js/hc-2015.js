(function() {
  'use strict';

  var menuButton = document.getElementById('menu-button');
  var menuContainer = document.getElementById('menu-collapse');

  if (menuButton && menuContainer) {
    addEvent(menuButton, 'click', toggleMenu);
    addEvent(menuButton, 'blur', function() {
      menuContainer.removeAttribute('open');
    });
  }

  /**
   * Toggle the open attribute on the menu container
   */
  function toggleMenu() {
    if (!menuContainer) {
      return;
    }

    if (menuContainer.hasAttribute('open')) {
      return menuContainer.removeAttribute('open');
    }
    return menuContainer.setAttribute('open', 'true');
  }

  /**
   * @param {HTMLElement} element
   * @param {string} eventName
   * @param {function} callback
   * @returns {*}
   */
  function addEvent(element, eventName, callback){
    if (element.attachEvent) {
      return element.attachEvent('on'+eventName, callback);
    }
    return element.addEventListener(eventName, callback, false);
  }
}());
