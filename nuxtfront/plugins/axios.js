export default ({ $axios, redirect, store, app }) => {

    if (process.browser) {

      $axios.onError((error) => {
        let errorString = JSON.stringify(error)
        if (document.getElementById("overlayNested")) {
          document.getElementById("overlayNested").style.display = "block"
        }
        // document.getElementById("overlayNested").style.display = "none"
        return Promise.reject(error)
      })
    
      $axios.onRequest(config => {
          config.baseURL = process.env.baseUrl
      })

    }
}
