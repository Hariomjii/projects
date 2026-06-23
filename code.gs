
function onOpen() {
  SpreadsheetApp.getUi()
    .createMenu('Help +')
    .addItem('Open Window Refresher', 'showRefresherSidebar')
    .addToUi();
}

function showRefresherSidebar() {
  const htmlOutput = HtmlService.createHtmlOutputFromFile('prg')
    .setTitle('Teleperformance Refresher')
    .setWidth(400);
  SpreadsheetApp.getUi().showSidebar(htmlOutput);
}
