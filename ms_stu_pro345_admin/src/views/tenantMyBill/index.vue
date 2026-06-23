<template>
    <div class="my-bill-container">
        <!-- 标题 -->
        <div class="title" 
            style="padding:20px 15px;
                font-weight: bold;
                background-color: white;"
        >
            我的账单
        </div>

        <div class="bill-container">
            <div class="bill-content">
            
                <!-- 账单查询功能 -->
                <el-form 
                    :inline="true"
                    >
                    <el-form-item
                        class="el-form-item-gap"
                        size="mini" 
                        label="合同编号："  
                        >
                        <el-input 
                            placeholder="请输入合同编号"
                            v-model="contractNum"
                            >
                        </el-input>
                    </el-form-item>

                    <el-form-item
                        class="el-form-item-gap"
                        size="mini" 
                        label="账单月份："  
                        >
                         <el-date-picker
                            v-model="contractYearMonth"
                            type="month"
                            placeholder="请选择日期">
                        </el-date-picker>
                    </el-form-item>
                
                    <el-form-item 
                        class="el-form-item-gap"
                        label="账单状态："  
                        size="mini" >
                        <el-radio-group
                            v-model="status"
                            >
                            <el-radio-button 
                                label="0"
                                >
                                已付
                            </el-radio-button>
                            <el-radio-button 
                                label="1"
                                >
                                未付
                            </el-radio-button>
                        </el-radio-group>
                    </el-form-item>

                    <el-form-item 
                        class="el-form-item-gap"
                        label="是否逾期："  
                        size="mini" >
                        <el-radio-group
                            v-model="overdue"
                            >
                            <el-radio-button 
                                label="0"
                                >
                                否
                            </el-radio-button>
                            <el-radio-button 
                                label="1"
                                >
                                是
                            </el-radio-button>
                        </el-radio-group>
                    </el-form-item>
                </el-form>

                <!-- 查询和重置按钮 -->
                <div class="research-reset">
                    <el-button 
                        type="primary"
                        size="mini"
                        @click="searchMyBill()"
                        >
                        查询
                    </el-button>
                    <el-button
                        size="mini"
                        @click="resetResearchForm()"
                        >
                        重置
                    </el-button>
                </div>

                <!-- 批量删除按钮 -->
                <div class="delete-btn"
                    
                    >
                    <el-button
                        size="mini"
                        type="danger"
                        >
                        删除
                    </el-button>
                </div>

                <!-- 表格数据 -->
                <el-table
                    size="mini"
                    ref="multipleTable"
                    :data="myBillData"
                    tooltip-effect="dark"
                    style="width: 100%"
                    v-loading="myBillTableloading"
                    element-loading-text="数据加载中"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255,1)"
                    >

                    <!-- 账期 -->
                    <el-table-column
                        prop="payment"
                        label="账期"
                        width="180"
                        :formatter="formatDateRange"
                        fixed="left"
                        >
                    </el-table-column>

                    <!-- 租户名称 -->
                    <el-table-column
                        prop="nickName"
                        label="租户名称"
                        width="160"
                        fixed="left"
                        >
                    </el-table-column>

                    <!-- 合同名称 -->
                    <el-table-column
                        prop="contractName"
                        label="合同名称"
                        width="400"
                        >
                    </el-table-column>

                    <!-- 合同编号 -->
                    <el-table-column
                        prop="contractNum"
                        label="合同编号"
                        width="400"
                        >
                    </el-table-column>

                    <!-- 账单状态 -->
                    <el-table-column
                        prop="status"
                        label="账单状态"
                        width="100"
                        >
                        <template slot-scope="scope">
                            <span>{{ scope.row.status == 0 ? '未收':'已收' }}</span>
                        </template>
                    </el-table-column>

                    <!-- 是否逾期 -->
                    <el-table-column
                        prop="overdue"
                        label="是否逾期"
                        width="100"
                        >
                        <template slot-scope="scope">
                            <span>{{ scope.row.overdue == 0 ? '未逾期':'逾期' }}</span>
                        </template>
                    </el-table-column>

                    <!-- 收款截止日 -->
                    <el-table-column
                        prop="deadline"
                        label="收款截止日"
                        :formatter="extractDate"
                        width="100"
                        >
                    </el-table-column>

                    <!-- 应付租金（元） -->
                    <el-table-column
                        prop="tenantMoney"
                        label="应付租金（元）"
                        width="120"
                        >
                    </el-table-column>

                    <!-- 押金（元） -->
                    <el-table-column
                        prop="deposit"
                        label="押金（元）"
                        width="400"
                        >
                    </el-table-column>

                    <!-- 物业管理费（元） -->
                    <el-table-column
                        prop="manageFee"
                        label="物业管理费（元）"
                        width="160"
                        >
                    </el-table-column>

                    <!-- 合计应收（元） -->
                    <el-table-column
                        prop="manageFee"
                        label="合计应收（元）"
                        width="300"
                        >
                    </el-table-column>

                    <!-- 备注 -->
                    <el-table-column
                        prop="status"
                        label="备注"
                        >
                    </el-table-column>

                    <!-- 操作 -->
                    <el-table-column
                        prop="address"
                        label="操作"
                        fixed="right"
                        >
                        <template slot-scope="scope">
                            <el-button 
                                v-if="scope.row.status == 0"
                                type="text"
                                size="mini"
                                @click="payMyBill(scope.row.billId)"
                                fixed="right"
                            >
                                付款
                            </el-button>
                        </template>
                        
                    </el-table-column>
                </el-table>

                <!-- 分页器 -->
                <div class="pagination">
                    <span></span>
                    <el-pagination
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        :current-page="pageNum"
                        :page-sizes="[5,10]"
                        :page-size="pageSize"
                        layout="total, sizes, prev, pager, next, jumper"
                        :total="total"
                        >
                    </el-pagination>
                </div>

                <div ref="alipayWap" v-html="alipay" />
            
            </div>
        </div>
        
    </div>
    
</template>
<script>
import { listMyBill } from '../../api/tenant/bill';
import { alipay } from '../../api/tenant/pay';
    export default{
        name:"my-bill",
        components:{},
        data(){
            return{
                alipay:'',
                myBillData: [],//我的账单表格数据
                pageNum:1,
                pageSize:5,
                contractNum:'',
                contractYearMonth:'',
                overdue:undefined,
                status:undefined,
                total:0,
                myBillTableloading:true,
                assignDialogVisible:false,//指派员工显隐控制
                assignform:{
                    region:''
                }
            } 
        },
        created(){
            this.getMyBillList();
        },
        methods:{
            //获取我的账单方法
            getMyBillList(){
                this.myBillTableloading = true;
                this.myBillData = [];
                const contractData = this.formatToYearMonth(this.contractYearMonth);
                const qureyData={
                    pageNum:this.pageNum,
                    pageSize: this.pageSize,
                    contractNum: this.contractNum,
                    nickName: this.nickName,
                    overdue: this.overdue,
                    status: this.status,
                    contractYearMonth:contractData
                }
                listMyBill(qureyData).then(res=>{
                    console.log('我的账单',res);
                    
                    this.myBillData = res.list;
                    this.myBillTableloading = false;
                    this.total = res.total;
                }).catch(()=>{

                })
            },

             //提交数据日期转换
            formatToYearMonth(dateStr) {
                if (!dateStr) return '';
                
                const date = new Date(dateStr);
                if (isNaN(date.getTime())) return '';
                
                const year = date.getFullYear();
                const month = String(date.getMonth() + 1).padStart(2, '0');
                
                return `${year}-${month}`;
            },

            //表格账期格式转换
            formatDateRange(row, column, cellValue) {
                if (!cellValue) return '--';
                
                // 正则匹配提取日期
                const dates = cellValue.match(/\d{4}-\d{2}-\d{2}/g);
                if (dates && dates.length >= 2) {
                    return `${dates[0]}~${dates[1]}`;
                }
                return cellValue;
            },

            extractDate(row, column, cellValue) {
                if (!cellValue) return '';
                
                // 方法1：直接截取前10个字符
                if (cellValue.length >= 10) {
                    return cellValue.substring(0, 10);
                }
            },

            //查询我的账单
            searchMyBill(){
                this.getMyBillList();
            },

            //重置查询表格
            resetResearchForm(){
                this.contractNum ='';
                this.nickName='';
                this.overdue=undefined;
                this.status=undefined;
                this.contractYearMonth='';
                this.getMyBillList();

            },
            
             //每页条数
            handleSizeChange(val) {
                this.pageSize = val;
                this.getMyBillList();
            },

            //当前页
            handleCurrentChange(val) {
                this.pageNum = val;
                this.getMyBillList();
            },
            
            payMyBill(billId) {
                const queryData = { billId };
                alipay(queryData).then(res => {
                    this.alipay = res.data;  // 假设 res.data 是表单html字符串
                    
                    this.$nextTick(() => {
                        const container = this.$refs.alipayWap;
                        if (!container) {
                            console.error('未找到 alipayWap 容器');
                            this.$message.error('支付容器加载失败');
                            return;
                        }
                        const form = container.children[0];
                        if (form && typeof form.submit === 'function') {
                            form.submit();
                        } else {
                            // 如果后端返回的是跳转 url 或其他，可以手动处理
                            // 例如直接跳转 window.location.href = res.data
                            this.$message.error(res.message);
                        }
                    });
                }).catch(error => {
                    console.error('支付请求失败：', error);
                    this.$message.error('获取支付表单失败');
                });
            }
        }
    }
</script>
<style lang="scss" scoped>
.my-bill-container{
    height: 100%;
    box-sizing: border-box;
    background-color: #f1f2f6;

    //标题样式
    .title{
        padding:20px 15px;
        font-weight: bold;
        background-color: white;
    }

    .bill-container{
        padding: 20px;
        background-color: #f1f2f6;
        box-sizing: border-box;
        font-weight: normal;

        .bill-content{
            padding: 20px;
            background-color: white;
            box-sizing: border-box;

            .research-reset{
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }

            .delete-btn{
                
                opacity:0
            }

            .pagination{
                margin-top: 20px;
                display: flex;
                justify-content: space-between;
            }
        }

        
    }
}

.el-form-item-gap{
    padding-right: 20px;
}
.center-select {
  display: flex;
  justify-content: center;
}

</style>