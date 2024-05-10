document.addEventListener('DOMContentLoaded', function() {
  const itemUrlInput = document.querySelector('#item_url'); // item_urlのinputフィールドを特定する
  const previewContainer = document.getElementById('preview'); // プレビューを表示するコンテナを特定する

  itemUrlInput.addEventListener('input', function() {
    const url = this.value;
    const videoId = extractVideoId(url); // YouTube ShortのURLからvideoIDを抽出

    if (videoId) {
      // videoIdが取得できた場合、アスペクト比16:9の動画プレビューを表示
      previewContainer.innerHTML = createVideoIframe(videoId);
    } else {
      // YouTube Short以外のURLが入力された場合、エラーメッセージを表示
      previewContainer.innerHTML = '<p>YouTube ShortのURLを入力してください。</p>';
    }
  });
});

// YouTube ShortのURLからvideoIDを抽出する関数
function extractVideoId(url) {
  if (url.includes('youtube.com/shorts/')) {
    const videoId = url.split('youtube.com/shorts/')[1].split('?')[0];
    return videoId;
  }
  return null;
}

// videoIdからYouTubeの動画プレビューを生成する関数
function createVideoIframe(videoId) {
  return `
    <iframe width="360" height="640" src="https://www.youtube.com/embed/${videoId}" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
  `;
}
