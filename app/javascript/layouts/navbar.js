
// Menu mobile
const closeSidebarButton = document.getElementById('close-sidebar')
const openSidebarButton = document.getElementById('open-sidebar')
const menuMobile = document.getElementById('menu-mobile')

function openSidebear(){
  menuMobile.classList.remove("hidden")
  menuMobile.classList.add("block")
}

function closeSidebar(){
  menuMobile.classList.remove("block")
  menuMobile.classList.add("hidden")
}

openSidebarButton.addEventListener('click', openSidebear)
closeSidebarButton.addEventListener('click', closeSidebar)

export default { openSidebear, closeSidebar }
