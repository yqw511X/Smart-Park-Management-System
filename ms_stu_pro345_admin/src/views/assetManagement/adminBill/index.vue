<template>
    <div class="bill-manage-container">
        <!-- 标题 -->
        <div class="title">
            账单管理
        </div>

        <div class="bill-container">
            <div class="bill-content">
            
                <!-- 账单查询功能 -->
                <el-form 
                    :inline="true">
                    <!-- 客户名称 -->
                    <el-form-item 
                        size="mini" 
                        label="客户名称："  
                        >
                        <el-input 
                            placeholder="请输入客户名称"
                            v-model="nickName"
                            >
                        </el-input>
                    </el-form-item>

                    <!-- 合同编号 -->
                    <el-form-item 
                        label="合同编号："
                        size="mini"   
                        >
                        <el-input
                            placeholder="请输入合同编号"
                            v-model="contractNum"
                            >
                        </el-input>
                    </el-form-item>

                    <!-- 账单月份 -->
                    <el-form-item 
                        label="账单月份："
                        size="mini">
                        <el-date-picker
                            v-model="contractYearMonth"
                            type="month"
                            placeholder="选择月">
                        </el-date-picker>
                    </el-form-item>

                    <!-- 账单状态 -->
                    <el-form-item 
                        label="账单状态："  
                        size="mini" 
                        >
                        <el-radio-group
                            v-model="status"
                            >
                            <el-radio-button 
                                label="0"
                                >
                                未收
                            </el-radio-button>
                            <el-radio-button 
                                label="1"
                                >
                                已收
                            </el-radio-button>
                        </el-radio-group>
                    </el-form-item>

                    <!-- 是否逾期 -->
                    <el-form-item 
                        label="是否逾期："  
                        placeholder="审批人"
                        size="mini"
                        >
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

                <!-- 查询与重置 -->
                <div class="search">
                    <el-button 
                        type="primary"
                        size="mini"
                        @click="searchBill()"
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
           
                <!-- 批量确认收款/删除 -->
                <el-row class="sure">
                    <el-button
                        type="primary"
                        size="mini"
                        @click="toSurePays"
                        >
                        确认收款
                    </el-button>

                    <el-button
                        v-if="multipleBillSelection.length >0"
                        type="danger"
                        icon="el-icon-delete"
                        @click="toDeleteBills()"
                        size="mini"
                        >
                        删除
                    </el-button>
                </el-row>

                <!-- 账单表格区域 -->
                <el-table
                    size="mini"
                    ref="multipleTable"
                    :data="billData"
                    tooltip-effect="dark"
                    style="width: 100%"
                    @selection-change="handleSelectionChange"
                    v-loading="billTableloading"
                    element-loading-text="数据加载中"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255,1)"
                    >

                    <el-table-column
                        type="selection"
                        width="55">
                    </el-table-column>

                    <el-table-column
                        prop="payment"
                        label="账期"
                        width="160"
                        :formatter="formatDateRange"
                        >
                        
                    </el-table-column>

                    <el-table-column
                        prop="nickName"
                        label="租户名称"
                        width="160"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="contractName"
                        label="合同名称"
                        width="300"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="contractNum"
                        label="合同编号"
                        width="300"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="status"
                        label="账单状态"
                        width="100"
                        >
                        <template slot-scope="scope">
                            <span>{{ scope.row.status == 0 ? '未收':'已收' }}</span>
                        </template>
                    </el-table-column>

                    <el-table-column
                        prop="overdue"
                        label="是否逾期"
                        width="100"
                        >
                        <template slot-scope="scope">
                            <span>{{ scope.row.overdue == 0 ? '未逾期':'逾期' }}</span>
                        </template>
                    </el-table-column>

                    <el-table-column
                        prop="deadline"
                        label="收款截止日"
                        :formatter="extractDate"
                        width="120"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="tenantMoney"
                        label="应收租金(元)"
                        width="100"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="deposit"
                        label="押金(元)"
                        width="120"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="address"
                        label="操作"
                        fixed ="right"
                        width="100"
                        >
                        <template slot-scope="scope">
                            <el-button 
                                type="text"
                                size="mini"
                                @click="toSurePay(scope.row)"
                                >
                                确认收款
                            </el-button>
                            <span>|</span>
                            <el-button 
                                type="text"
                                size="mini"
                                @click="toDeleteBill(scope.row)"
                                >
                                删除
                            </el-button>
                        </template>
                    </el-table-column>

                </el-table>

                <!-- 分页区域 -->
                <div class="pagination">
                    <span></span>
                    <!-- 分页器 -->
                    <el-pagination
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        :current-page="pageNum"
                        :page-sizes="[5,10]"
                        :page-size="pageSize"
                        layout="total, sizes, prev, pager, next, jumper"
                        :total="total">
                    </el-pagination>
                </div>

            </div>
        </div>
        
    </div>
   
</template>
<script>
import { listBill,surePay,deleteBill} from '../../../api/asset/bill';
    export default{
        name:"bill",
        data(){
            return{
                billData: [],//账单数据列表
                pageNum:1, //当前页
                pageSize: 5,//页码大小
                contractNum:'',
                nickName:'',
                overdue:'',
                status:'',
                contractYearMonth:'',
                total:0,
                billTableloading:true,

                multipleBillSelection: []
            } 
        },
        created(){
            this.getBillList();
        },
        computed:{
            
        },
        methods:{
            //分页查询账单列表
            getBillList(){
                this.billTableloading = true;
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
                
                listBill(qureyData).then(res=>{
                    this.billData = res.list;
                    this.billTableloading = false;
                    this.total = res.total;
                }).catch(()=>{

                })
            },

            //表格日期转换
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

            //提交数据日期转换
            formatToYearMonth(dateStr) {
                if (!dateStr) return '';
                
                const date = new Date(dateStr);
                if (isNaN(date.getTime())) return '';
                
                const year = date.getFullYear();
                const month = String(date.getMonth() + 1).padStart(2, '0');
                
                return `${year}-${month}`;
            },

            //查询账单
            searchBill(){
                this.getBillList();
            },

            //重置查询表格
            resetResearchForm(){
                this.contractNum ='';
                this.nickName='';
                this.overdue=undefined;
                this.status=undefined;
                this.contractYearMonth='';
                this.getBillList();
            },

            //变换每页条数
            handleSizeChange(val) {
                this.pageSize = val;
                this.getBillList();
            },

            //变换当前页 
            handleCurrentChange(val) {
                this.pageNum = val;
                this.getBillList();
            },

            //确认收款方法
            paySure(billIds){
                surePay(billIds).then(res=>{
                    console.log(res);
                
                    if(res.message == 200){
                        this.$message.success(res.message);
                    }else{
                        this.$message.error(res.message);
                    }
                }).catch(()=>{

                })
            },

            //确认收款(单个)
            toSurePay(row){
                this.$confirm(`确认收款当前账单信息？`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    const qureyData ={
                        billIds: row.billId
                    } ;

                    this.paySure(qureyData);
                    
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消收款'
                    });
                });
            },

            //批量确认收款
            toSurePays(){
                if (this.multipleBillSelection.length <1){
                    this.$message.warning('当前未选择任何账单!')
                    return
                } 
                this.$confirm(`确认收款已选的${this.multipleBillSelection.length}条账单信息？`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    const billIds = this.multipleBillSelection.map(({ billId }) => billId);
                    console.log('批量收款账单id',billIds);
                    
                    this.paySure(billIds);
                    
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消收款'
                    });
                });
            },
            
            //删除账单方法
            billDelete(billIds){
                deleteBill(billIds).then(res=>{
                    console.log(res);
                    if(res.status ==200){
                        this.$message.success(res.message);
                    }else{
                        this.$message.error(res.message);
                    }
                }).catch(()=>{

                })
                this.getBillList();
            },

            //确认删除(单个)
            toDeleteBill(row){
                
                this.$confirm(`确认删除当前账单信息？`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    const billIds = row.billId;
                    this.billDelete(billIds);
                    
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });

            },

            //批量确认删除
            toDeleteBills(){
                this.$confirm(`确认删除已选的${this.multipleBillSelection.length}条账单信息？`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    const billIds = this.multipleBillSelection.map(({ billId }) => billId);
                    
                    this.billDelete(billIds);
                    
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },

            //全选
            toggleSelection(rows) {
                if (rows) {
                rows.forEach(row => {
                    this.$refs.multipleBillSelection.toggleRowSelection(row);
                });
                } else {
                this.$refs.multipleBillSelection.clearSelection();
                }
            },

            //多选
            handleSelectionChange(val) {
                this.multipleBillSelection = val;
            }
        }
    }
</script>
<style lang="scss" scoped>
.bill-manage-container{
    box-sizing: border-box;

    //标题样式
    .title{
        padding:20px 15px;
        font-weight: bold;
        background-color: white;
        font-size: 18px;
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

            .search{
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }

            .sure{
                margin-bottom: 20px;
            }

            .pagination{
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }
        }
        
        
    }
}
</style>

