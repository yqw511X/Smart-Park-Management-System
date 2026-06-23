<template>
    <div class="console-container">
        <!-- 工作台大标题区域 -->
        <div class="title"
            style="padding:20px 15px;
                font-weight: bold;
                background-color: white"
            >
            工作台
        </div>
        <div class="console-content">
            

            <!-- 工作台卡片区域 -->
            <div class="card-container">
                <el-card v-for="(items,index) in totalData " :key="index" class="box-card">
                    <span class="title">{{items.title}}</span>
                    <div class="bill">{{ formatNumber(items.bill) }}</div>
                    <div class="bottom">
                        <span class="bar">总已收款 ¥ {{formatNumber(items.finish)}}</span>
                        <span class="bar">总未收款 ¥ {{formatNumber(items.unfinished)}}</span>
                    </div>
                </el-card>
            </div>

            <!-- 柱状图区域 -->
            <div class="chart-container">
                <el-tabs v-model="activeName" @tab-click="handleNameChange">
                    <el-tab-pane label="应收款" name="total"></el-tab-pane>
                    <el-tab-pane label="已收款" name="finished"></el-tab-pane>
                    <el-tab-pane label="未收款" name="unfinished"></el-tab-pane>
                </el-tabs>
                <div class="line-chart" size="mini">

                </div>
            </div>
        </div>
        
    </div>
   

</template>

<script>
import { workbenchdata,paidchart,receivablechart,unpaidchart } from '../../api/console/data';
import * as echarts from 'echarts';
    export default{
        name:"consle",
        data(){
            return{
                totalData:{

                },
                activeName: 'total', //柱状图 标签页指示器
                chartInstance:null, //图表实例
                chartData:{
                    total:
                    {
                        data: [],
                    },
                    finished:
                    {
                        data: [],
                    },
                    unfinished:
                    {
                        data: [],
                    }
                } //图表数据

            }
        },
        
        created(){
            this.getworkbenchdata();
        },
        mounted(){
            this.initChart();
            this.updateChart();
        },
        beforeDestroy() {
            if (this.chartInstance) {
                this.chartInstance.dispose()
            }
        },
        methods:{
            //获取数据概览
            getworkbenchdata(){
                workbenchdata().then(res=>{
                    let data = res.data;
                    data.propertyBill.title = '物业费应收';
                    data.rentBill.title = '租金应收';
                    data.totalBill.title = '本月总应收';
                    data.utilityBill.title = '水电费应收';
                    this.totalData = data;
                }).catch(()=>{
                    
                })

                //获取已收款数据
                paidchart().then(res=>{
                    console.log('已收款',res);
                    this.chartData.finished = res.data.values;
                }).catch(()=>{

                })

                //获取应收款数据
                receivablechart().then(res=>{
                    console.log('应收款',res);
                    this.chartData.total = res.data.values;
                }).catch(()=>{

                })

                //获取未收款数据
                unpaidchart().then(res=>{
                    console.log('未收款',res);
                    this.chartData.unfinished = res.data.values;
                }).catch(()=>{

                })
            
            },

           

            // 格式化数字（不带符号）
            formatNumber(value) {
                if (value === null || value === undefined || isNaN(value)) {
                    return '0.00'
                }
                const num = parseFloat(value)
                return num.toFixed(2)
            },
            //初始化柱状图
            initChart()
            {
                const lineChart = echarts.init(document.querySelector('.line-chart'));
                this.chartInstance = lineChart;
            },

            //标签页切换事件
            handleNameChange(tab,event) {
                this.activeName = tab.name;
                this.updateChart();
            },

            //柱状图数据更新
            updateChart()
            {
                 // 清除之前的定时器
                if (this.updateTimer) {
                clearTimeout(this.updateTimer)
                }
                
                // 设置新的定时器
                this.updateTimer = setTimeout(() => {
                if (!this.chartInstance) return

                const series = this.chartData[this.activeName]
      
                const option ={
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                        type: 'shadow'
                        }
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'category',
                        data: ['01月', '02月', '03月', '04月', '05月', '06月', '07月','08月', '09月', '10月', '11月', '12月'],
                        name:'月份',
                        axisTick: {
                            alignWithLabel: true
                        }
                    },
                    yAxis: {
                        type: 'value',
                        name: '金额(元)'
                    },
                    series: [
                        {
                            name: 'Direct',
                            type: 'bar',
                            barWidth: '60%',
                            data: series.data,
                        }
                    ]
                }
                this.chartInstance.setOption(option);
                
                this.updateTimer = null
                }, 300) // 300ms 延迟
                if (!this.chartInstance) return;

                
            },
        },
        watch: {
            // 监听activeNmae变化，自动更新图表
            activeName: {
                handler() {
                    this.updateChart()
                },
                immediate: true
            }
        }
    }   
</script>

<style lang="scss" scoped>
.console-container{
    width: 100%;
    height: 100vh;
    background-color: #f1f2f6;

    //工作台大字标题样式
    .title{
        width: 100%;
        padding:20px 15px;
        font-size: 18px;
        height: 63px;
        font-weight: bold;
        box-sizing: border-box;
        background-color: white;
    }
    
    .console-content{
        width: 100%;
        height: 100%;
        display: flex;
        gap: 5px;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
        box-sizing: border-box;
        padding: 20px;

        

        //工作台卡片区域样式
        .card-container{
            width: 100%;
            display: flex;
            justify-content: space-between;
            gap: 10px;
            height: 160px;
            box-sizing: border-box;
            
            // 卡片样式
            .box-card{
                flex:1;
                width: 280px;
                height:160px ;
                padding: 5px;
                box-sizing: border-box;
                
                .title{
                    color: gray;
                    font-size: 12px;
                    padding: 0;
                    font-weight: normal;
                }
                .bill{
                    height: 80px;
                    font-size: 18px;
                    font-weight: 200;
                    border-bottom: 1px solid rgba(128, 128, 128, 0.411);
                    padding-top: 5px;
                    margin-bottom: 5px;
                    box-sizing: border-box;
                }

                .bottom{
                    display: flex;
                    justify-content: space-between;

                    .bar{
                    color: gray;
                    font-size: 12px;
                    padding: 0;
                }
                }
                
            }
        }

        //柱状图区域样式
        .chart-container{

        
            flex: 1;
            padding: 10px 20px;
            margin:20px;
            box-sizing: border-box;
            width: 100%;
            background-color: white;
            
            .line-chart{
                margin: auto;
                width: 80%;
                height: 80%;
            }
        }
    }

    
    
}
</style>