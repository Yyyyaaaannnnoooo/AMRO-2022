// 1 liner to use as logpoint message!
// .. to be used here:
// "/s/desktop/79946f8f/jsbin/desktop_polymer.vflset/desktop_polymer.js"
// search cmd + f: b.durationHoveredMs
eval("fetch('http://127.0.0.1:8000/midi?note=60&channel=0&velocity=127',{method:'GET',mode:'no-cors'}).then(response=>response.text()).then(data=>console.log(data)).catch(error=>{console.log(error);});")