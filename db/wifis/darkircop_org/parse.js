var cheerio = require('cheerio');
var fs = require('fs');

var html = fs.readFileSync('darkirc.html', 'utf8');

var $ = cheerio.load(html);

var results = [];
$('tr', 'table').each(function (i, table_row) {
    if ($('td', table_row)[2] && $('td', table_row)[2].children[0]) {
        var result = {
            id: $('td', table_row)[0].children[0].data,
            ssid: $('td', table_row)[2].children[0].data,
            password: $('td', table_row)[3].children[0].data
        };
        if (result.password) {
            results.push(result);
        }
    }
});

console.log(results);