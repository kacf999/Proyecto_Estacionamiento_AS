<!DOCTYPE html>
<html>
<head>
    <title>Streaming en vivo</title>
    <!-- Incluye la biblioteca video.js -->
    <link href="https://vjs.zencdn.net/7.14.3/video-js.css" rel="stylesheet">
    <script src="https://vjs.zencdn.net/7.14.3/video.js"></script>

    <!-- Incluye el complemento videojs-http-streaming (para HLS) -->
    <script src="https://unpkg.com/videojs-contrib-hls@5.17.1/dist/videojs-contrib-hls.js"></script>
</head>
<body>
    <h1>Streaming en vivo</h1>
    <video id="player" class="video-js vjs-default-skin" controls width="640" height="360"></video>

    <script>
        // Configura la instancia de video.js
        var options = {
            html5: {
                hls: {
                    overrideNative: true
                }
            }
        };
        var player = videojs('player', options);

        // Carga la fuente del video HLS
        player.src({
            src: 'https://service-stitcher.clusters.pluto.tv/v1/stitch/embed/hls/channel/5f1acce7f17797000718f9be/master.m3u8?advertisingId=channel&appName=rokuchannel&appVersion=1.0&bmodel=bm1&content=channel&content_rating=ROKU_ADS_CONTENT_RATING&content_type=livefeed&coppa=false&deviceDNT=1&deviceId=channel&deviceMake=rokuChannel&deviceModel=web&deviceType=rokuChannel&deviceVersion=1.0&embedPartner=rokuChannel&is_lat=1&platform=web&rdid=channel&tags=ROKU_CONTENT_TAGS',
            type: 'application/x-mpegURL'
        });

        // Reproduce el video
        player.play();
    </script>
    <video controls width="640" height="360">
    <source src="https://service-stitcher.clusters.pluto.tv/stitch/hls/channel/5e82bb378601b80007b4bd78/master.m3u8?advertisingId=&appName=web&appStoreUrl=&appVersion=DNT&app_name=&architecture=&buildVersion=&deviceDNT=0&deviceId=5e82bb378601b80007b4bd78&deviceLat=&deviceLon=&deviceMake=web&deviceModel=web&deviceType=web&deviceVersion=DNT&includeExtendedEvents=false&marketingRegion=US&serverSideAds=false&sid=925&terminate=false&userId=" type="application/x-mpegURL">
	</video>
    
</body>
</html>
