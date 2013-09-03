class TopicController < UIViewController
  extend IB

  attr_accessor :topic

  outlet :webview

  def viewDidLoad
    NSLog topic.to_s
    if topic['kind'] == 'text'
      webview.loadHTMLString(topic[:text],baseURL:nil) 
    else
      url = NSURL.URLWithString(topic['link'])
      request = NSURLRequest.requestWithURL(url)
      webview.loadRequest request
    end
  end
end