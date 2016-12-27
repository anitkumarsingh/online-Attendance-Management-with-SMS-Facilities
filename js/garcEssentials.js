/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * Ramkumar oct 9,4:33 PM
 */
 function smartColumns(size,colheight) { //Create a function that calculates the smart columns

    //Reset column size to a 100% once view port has been adjusted
    $("ul.column").css({ 'width' : "100%"});

    var colWrap = $("ul.column").width(); //Get the width of row
    var colNum = Math.floor(colWrap / size); //Find how many columns of 150px can fit per row / then round it down to a whole number
    var colFixed = Math.floor(colWrap / colNum); //Get the width of the row and divide it by the number of columns it can fit / then round it down to a whole number. This value will be the exact width of the re-adjusted column
    colheight+="px";
    $("ul.column").css({ 'width' : colWrap}); //Set exact width of row in pixels instead of using % - Prevents cross-browser bugs that appear in certain view port resolutions.
    $("ul.column li").css({ 'width' : colFixed});
    $(".block").css({ 'height' : colheight}); //Set exact width of the re-adjusted column

            }
function clearmsg(){
    $('.status').hide();
    //$('#err').html("");
    clearTimeout(t);
}
 function encodeMyHtml(url) {
    encodedHtml = escape(url);
    encodedHtml = encodedHtml.replace(/\//g,"%2F");
    encodedHtml = encodedHtml.replace(/\?/g,"%3F");
    encodedHtml = encodedHtml.replace(/=/g,"%3D");
    encodedHtml = encodedHtml.replace(/&/g,"%26");
    encodedHtml = encodedHtml.replace(/@/g,"%40");
    encodedHtml = encodedHtml.replace(/\+/g,"%2B");
    return encodedHtml;
}


