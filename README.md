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
基本的我们上面已经做到了,现在我们看看怎么跳转,上面其实也说过了,导航控制器是一个栈,为我们提供了push的方法,把我们想要跳转的另一个控制器压入栈中,也提供了pop方法,让我们可以回到某个想要的控制器.下面我们用代码看看怎么做.
```
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated; 
// Uses a horizontal slide transition. Has no effect if the view controller is already in the stack.
```
我们直接用上述的方法,就可以进行界面的推进,下面我们新建多两个类,这些我都会在demo上添加,这里就不多浪费笔墨来写了,有推自然有返回,Objective-C中提供了三种方法
```
- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated; 
- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated; 
```
第一个方法会直接返回上一个控制器.第二个方法则会返回栈中的其中一个控制器,这个控制器必须在栈中.第三个方法会直接回到首页.
![2016-08-11 12_03_36.gif](http://upload-images.jianshu.io/upload_images/1711673-3e4772630c3e56af.gif?imageMogr2/auto-orient/strip)
这里发现我第三个界面返回按钮的颜色,以及导航栏整个都变样了,那我是怎么做到的呢.返回按钮很简单,我们只要改变barTintStyle就行啦
```
[[self.navigationController navigationBar] setBarTintColor:[UIColor colorWithRed:17.0/255 green:107.0/255 blue:173.0/255 alpha:1]];
```
接下来我们看看是怎么让导航栏的颜色改变的,其实我们是让他变成透明了.下面要提一下NavigationBar的两个属性
```
/*
Same as using UIBarPositionAny in -setBackgroundImage:forBarPosition:barMetrics. Resizable images will be stretched
vertically if necessary when the navigation bar is in the position UIBarPositionTopAttached.
*/
- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
/* Default is nil. When non-nil, a custom shadow image to show instead of the default shadow image. For a custom shadow to be shown, a custom background image must also be set with -setBackgroundImage:forBarMetrics: (if the default background image is used, the default shadow image will be used).
 */
@property(nullable, nonatomic,strong) UIImage *shadowImage NS_AVAILABLE_IOS(6_0) 

```
一个是背景图片,一个是下划线,如果我们不处理shadowImage,那么系统会默认给出一条线,如图所示
![Snip20160811_3.png](http://upload-images.jianshu.io/upload_images/1711673-edbb2ebab5d783ee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
同样的如果不处理backgroundImage,系统也会默认给出一张图片,如图所示
![Snip20160811_4.png](http://upload-images.jianshu.io/upload_images/1711673-34ca320c3e25aa8a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
我们只需要把空的图片对象作为这两个属性的值,那么就能达到我们想要的效果了.
```
[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
```
千万注意,一旦修改了这些属性,接下来不管你push还是pop.出现的导航栏都会相应改变,所以我们必须要在pop或者push之前再改变导航栏的状态.GIF中可以看出我返回的时候,之前的界面的按钮颜色也变成了白色,这就是我只改了导航栏颜色,而没有修改返回按钮颜色导致的.
************
就写到这里了.感谢看到这里的人.相关的代码都在demo上,有兴趣的人可以去下载.谢谢.
