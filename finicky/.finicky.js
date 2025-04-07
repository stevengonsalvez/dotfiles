module.exports = {
    defaultBrowser: "Arc",
    // rewrite: [
    //   {
    //     // Redirect all urls to use https
    //     match: ({ url }) => url.protocol === "http",
    //     url: { protocol: "https" }
    //   }
    // ],
    handlers: [
      {
        // Open apple.com and example.org urls in Safari
        match: ["apple.com/*", "example.org/*"],
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in Firefox
        match: /mobius/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in Firefox
        match: /collab/,
        browser: "Safari"
      },
      {
        match: /gitlab.agile/,
        browser: "Safari"
      },
      {
        match: /dynatrace/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /intra/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /amazonaws/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /pages-gitlab/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /adobe/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /hr.bt/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /slack/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /mural/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /btgroupcloud/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /performancemanager/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /btkanoprd/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /concursolutions/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /MyContractor/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /login.microsoft/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /office4/,
        browser: "Safari"
      },
      {
        // Open any url that includes the string "workplace" in safari
        match: /btgroupcloud/,
        browser: "Safari"
      },
      {
        // Open google.com and *.google.com urls in Google Chrome
        match: [
          "google.com/*", // match google.com urls
          "*.google.com/*", // match google.com subdomains
        ],
        browser: "Google Chrome"
      }
    ]
  };