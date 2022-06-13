console.log('background.js LOADED!');

const yt_ids = {
  next: 'next',
  next_res: 'next-res',
  player: 'player',
  player_res: 'player-res',
  browse: 'browse',
  what_to_watch: 'wtw',
  log: 'log',
  watchtime: 'wt',
  qoe: 'qoe',
  search: 'search',
  playlist: 'edit_playlist',
  log_point: 'log_point',
  page_ad: 'pagead/interaction'
}

browser.webRequest.onBeforeRequest.addListener(
  tamper_request_listener,
  { urls: ["<all_urls>"] },
  ["blocking", "requestBody"]
);

browser.webRequest.onBeforeSendHeaders.addListener(
  tamper_header_listener,
  { urls: ["<all_urls>"] },
  ["requestHeaders", "blocking"]
);

function tamper_request_listener(e) {
  if (e.method === 'POST') {
    if (!!e.requestBody.raw) {
      /**
       * solution to translate RAW bytes into readable JSON
       * Source of the solution found here:
       * https://developers.google.com/web/updates/2012/06/How-to-convert-ArrayBuffer-to-and-from-String
       */
      const raw_body = String.fromCharCode.apply(null, new Uint8Array(e.requestBody.raw[0].bytes))
      const json = JSON.parse(raw_body)
      if (e.url.includes('log_event?')) {
        console.log('///~~~ log event ~~~///')
        console.log(json)
        // this below is for the final payload only
        for (let i = json['events'].length - 1; i >= 0; i--) {
          const event = json['events'][i]
          if (!!event['finalPayload']) {
            console.log('///~~~///~~~///~~~~///')
            console.log(event)
            console.log('window opened or closed')
            send_message()
            break
          }
          // if there is the wish to send all the log events
          // un comment the below and remove break above
          // send_message()
        }


      }
    }
  }

}


function tamper_header_listener(e) {
  if (e.url.includes('watchtime?')) {
    console.log("///~~~ watchtime ~~~///")
    const json = get_params_from_url(e.url)
    // send_message(yt_ids.watchtime, json)
    // send_message()
    console.log(json)
    console.log('///~~~~~~~~~~~~///')
  }
  if (e.url.includes('pagead/interaction')) {
    console.log("///~~~ pagead ~~~///")
    const json = get_params_from_url(e.url)
    // send_message(yt_ids.page_ad, json)
    // send_message()
    console.log(json);
    console.log('///~~~~~~~~~~~~///')
  }
}

/**
 * 
 * @param {String} url 
 * @returns Object containig the parameters of the request
 */
function get_params_from_url(url) {
  url = decodeURI(url);
  if (typeof url === 'string') {
    let params = url.split('?');
    let eachParamsArr = params[1].split('&');
    let obj = {};
    if (eachParamsArr && eachParamsArr.length) {
      eachParamsArr.map(param => {
        let keyValuePair = param.split('=')
        let key = keyValuePair[0];
        let value = keyValuePair[1];
        obj[key] = value;
      })
    }
    return obj;
  }
}




function send_message(channel, note, velocity) {
  // DEFAULTS
  note = note || 60;
  velocity = velocity || 127;
  channel = channel || 0;
  fetch(`http://127.0.0.1:8000/midi?note=${note}&channel=${channel}&velocity=${velocity}`, {
    method: 'GET',
    mode: 'no-cors'
  })
    .then(response => response.text())
    .then(data => console.log(data)
    )
    .catch(error => {
      console.log(error);
    });
}