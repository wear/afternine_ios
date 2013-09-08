class CustomTheme
  def statusBarStyle
    UIStatusBarStyleLightContent
  end

  def navigationBackgroundForBarMetrics(metrics)
    name = "navigationBackground"
    # name += "Landscape" if (metrics == UIBarMetricsLandscapePhone)
    image = UIImage.imageNamed name 
    image = image.resizableImageWithCapInsets UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
    image
  end

  def barButtonBackgroundForState(state,style:style,barMetrics:barMetrics)
    name = "barButton"
    # name += "Done" if style == UIBarButtonItemStyleDone
    # name += 'Landscape' if barMetrics == UIBarMetricsLandscapePhone
    # name += 'Highlighted' if state == UIControlStateHighlighted
    image = UIImage.imageNamed name
    image = image.resizableImageWithCapInsets UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)
    image
  end

  def backBackgroundForState(state,barMetrics:barMetrics)
    name = "backButton"
    # name += "Landscape" if barMetrics == UIBarMetricsLandscapePhone
    # name += "Highlighted" if state == UIControlStateHighlighted
    image = UIImage.imageNamed name
    image = image.resizableImageWithCapInsets UIEdgeInsetsMake(0.0, 17.0, 0.0, 5.0)
    image
  end

  # def tabBarBackground
  #   image = UIImage.imageNamed("tabBarBackground",resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10))
  #   return image;
  # end

  # def tabBarSelectionIndicator
  #   return UIImage.imageNamed("tabBarSelectionIndicator")
  # end
  def navigationTextColor 
    UIColor.colorWithRed(1.0,green:1.0,blue:1.0,alpha:1.0)
  end

  def navigationTextShadowColor 
    UIColor.whiteColor
  end

  def navigationFont
    UIFont.fontWithName("HelveticaNeue-Medium",size:17.0)
  end

  def barButtonFont
    UIFont.fontWithName("HelveticaNeue-Light",size:15.0)
  end

  def baseTintColor
    nil
  end

  def shadowOffset
    return CGSizeMake(0, 0);
  end

  def topShadow
    return nil;
  end

  def toolbarBackgroundForBarMetrics(metrics)
    name = "toolbarBackground"
    image = UIImage.imageNamed name
    image = image.resizableImageWithCapInsets(UIEdgeInsetsMake(0.0, 8.0, 0.0, 8.0))
    return image
  end

  # def bottomShadow
  #   return UIImage.imageNamed("bottomShadow")
  # end



end