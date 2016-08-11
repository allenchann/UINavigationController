#导航控制器
![导航栏.png](http://upload-images.jianshu.io/upload_images/1711673-48522038af1662c1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
我们经常看到像这样的APP界面,由顶部一个导航栏作为纽带,连接整个APP.怎样实现它呢,iOS中有一个专门的类
```
UINavigationController
```
  - 导航控制器可以理解为一个容器,它提供了一个栈.最底部存放了我们要显示的根视图控制器,并为我们提供了push的方法,把我们想要跳转的另一个控制器压入栈中,也提供了pop方法,让我们可以回到某个想要的控制器.
  - 去除storyboard
    
![QQ20160726-1@2x.png](http://upload-images.jianshu.io/upload_images/1711673-7b477f5b41a10d1c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

  - 生成控制器,在didFinishLaunchingWithOptions方法中,加入以下代码
<pre><code>
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];

    ViewController *root =[[ViewController alloc]init];

    root.title = @"首页";

    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:root];

    self.window.rootViewController =nav;

    [self.window makeKeyAndVisible];

</code></pre>
这样就能实现第一张图的效果,接下来是一些基本的设置.
  - 导航栏颜色(barTintColor)
    <pre><code>
self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
</code></pre>

![
![Uploading QQ20160726-3@2x_207292.png . . .]
](http://upload-images.jianshu.io/upload_images/1711673-8fdb1806077d4654.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

  - 标题颜色
 <pre><code>
NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];

    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];

    titleAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];

    [self.navigationController.navigationBar setTitleTextAttributes:titleAttr];
</code></pre>
![QQ20160726-3@2x.png](http://upload-images.jianshu.io/upload_images/1711673-5cba28460f72885f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这时候我们发现上面的电池栏颜色黑乎乎的很难看,我们会发现有些APP上面是白色的字体颜色,那怎么改变呢,下面提供两种方法,
- 第一种
```
//设置电池栏的颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
```
是不是有人加了没效果呢,没错.因为我们还少做了一步.找到info.plists.在里面添加下述字段,下拉条拉到最后就可以看到这个字段了,然后类型选择Boolean,值为NO;就能达到我们想要的效果
```
View controller-based status bar appearance
```
这样就能达到效果了,但细心的人可能发现,API中这个方法在9.0中不建议使用了.

```
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle animated:(BOOL)animated
 NS_DEPRECATED_IOS(2_0, 9_0, "Use -[UIViewController preferredStatusBarStyle]") __TVOS_PROHIBITED;
```
那我们来看看他推荐使用的方法
```
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
```
不过注意,如果在Info.pilsts里添加了我们上面说的字段,这段代码就不会生效了.把它删掉,再运行看效果,我们发现还是黑色的.为什么会这样.我们看官方的文档上的注释.
These methods control the attributes of the status bar when this view controller is shown. They can be overridden in view controller subclasses to return the desired status bar attributes.
他这里改变的是我们要展示的控制器的状态栏.但是我们这里覆盖的.是ViewController里的这个方法,而我们在AppDelgate里面设置的根控制器,是UINavigationController,所以我们改变的并非是他的状态栏.那怎么做呢?提供三种思路解决方案
- 方案一:(类目:category)
我们可以通过为UINavigationController添加类目,然后重写他的preferredStatusBarStyle方法
```
@interface UINavigationController (Status)
@end
@implementation UINavigationController (Status)
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
```
- 方案二:继承
我们可以新建一个继承自UINavigationController的类,然后重写这个方法,这个很简单,就不多说了,demo上有
- 方案三
我们在显示控制器上,可以获取到navigationController的navigationBar,然后我们可以修改它的barStyle.
```
//设置电池栏的颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
```
![Snip20160811_1.png](http://upload-images.jianshu.io/upload_images/1711673-fe050cf991e4f05a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


********
