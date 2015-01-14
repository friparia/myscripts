# 报表模块

## 主要工作

* 报表的功能(产品设计、细化功能，除了展示方面的例如原先只统计工作日之类的功能)
* 指标(组)的接口设计与具体实现
* 前端工具的设计(js/css/Echarts)
* 排序和TOP N(还在思索当中)
* excel高效写入 

### 任务列表

1. 报表功能产品设计
2. 设计报表中的指标，对指标进行分组
3. 对设计好的指标(组)进行具体的实现
4. 报表工具的设计(用户体验)
5. 了解并熟悉Echarts的使用
6. 常用报表的实现

## 报表结构

### 逻辑结构

将所有报表进行抽象，自定义报表和常用报表其实都是由报表工具或者手动生成，而常用报表会有更多的展示方案。

#### 自定义报表

用户通过报表工具生成自定义报表

#### 常用报表

发布产品时自带的版本不同的报表(标准版、企业版、旗舰版)

### 数据结构

报表模型类，相当于一个报表模型
```php
//model/RepProp.php
class RepProp{
    static $table_name = 'rep_report';
    public function get_array();
}
?>
```
`rep_report`表一共有9个字段(待完善)
* `id` 就是这个报表的id~
* `name` 报表的名称
* `group_id` 要统计的设备组的id(还未开发)
* `starttime`  统计的开始时间(需要根据实际情况调整)
* `endtime` 统计的结束时间
* `topn` 是否为TOPN，如果是，N值为多少
* `url` 该报表的url链接，自定义的一般是id,提供的是字符串
* `type` 报表的类型，CUSTOMIZE,STANDARD,ENTERPRISE,ULTIMATE
* `properties` 一个json数组，表示该报表有哪些指标、字段

`get_array()`返回这个报表数组

```php
//autoload/Report.php
abstract class ReportAbstractFactory{
    abstract public function isAuthorized();
    static public $propGroups;
    public function getPropValues($props);
}
```

具体实现指标(组)的方式如下~
先在上述`$propGroups`添加指标数组如
```php
'DemoGroup' => ['DemoName', 'DemoUsage', 'DemoStatus']
```
//变量采用驼峰命名~
```php
class DemoGroupPropFactory extends ReportPropAbstractFactory{
    protected $demoName;
    protected $demoUsage;
    protected $demoStatus;
    //因为授权方式还未知~暂时留空返回true
    public function isAuthorized(){
        return true;
    }

    /**
     * 实例初始化，也是这个指标组实际计算的地方
     *
     * @param $id 设备or接口or链路的Id
     *
     * @return $this;
     */
    public function __construct($id){
        $this->demoName = "balabala";
        $this->demoUsage = ModelA::find($modelid)->usage;
        $this->demoStatus = "again balabla";
    }
}
```

得到某个报表的对应的数组的方法如下~
```php
$arr = RepReport::find($id)->get_array();
```
