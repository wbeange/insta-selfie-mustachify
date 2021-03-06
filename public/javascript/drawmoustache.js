console.log('really?', data);

// instagram faces with mustaches

// html5 canvas
var canvas = document.getElementById('myCanvas');
var context = canvas.getContext('2d');

// instagram image
var instagramImgObj = new Image();
instagramImgObj.src = data.url;
instagramImgObj.onload = function() {

  // drawn instagram selfie image on the canvas
  context.drawImage(this, 0, 0);

  // run through matches
  _.each(data.face_detection, function(face) {

    // formula
    var noseX = face.nose.x;
    var noseY = face.nose.y;

    var mouthLX = face.mouth_l.x;
    var mouthLY = face.mouth_l.y;

    var mouthRX = face.mouth_r.x;
    var mouthRY = face.mouth_r.y;

    var faceSizeWidth = face.boundingbox.size.width;
    var faceSizeHeight =face.boundingbox.size.height;

    // mustache should be proportional to the face
    var mustacheImageWidth = 600;
    var mustacheImageHeight = 152;
    var faceProportion = 0.65;
    var mustacheWidth = faceSizeWidth * faceProportion;
    var mustacheHeight = faceSizeWidth / ( mustacheImageWidth / mustacheImageHeight);

    // moustache falls in the center of the mouth left / mouth right / nose middle triangle
    var moustacheX = ( ( mouthLX + ( ( mouthRX - mouthLX ) / 2 ) ) - ( mustacheWidth / 2 ) );
    var moustacheY = ( noseY + ( ( ( ( mouthLY + mouthRY ) / 2 ) - noseY ) / 2 ) );

    var mustacheObj = new Image();
    mustacheObj.src = '/images/mustache.png';
    mustacheObj.onload = function() {

      context.drawImage(this, moustacheX, moustacheY, mustacheWidth, mustacheHeight);
    };

  });
};