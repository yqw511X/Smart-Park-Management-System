<template>
    <div>
        <!-- 租赁场地信息区域 -->
        <div class="rental-venue-info">
            <div>付款计划</div>

            <!-- 表格数据 -->
            <div class="rental-venue-content">
                <el-table
                    :data="billData"
                    style="width: 100%">
                    <el-table-column
                        type="index"
                        width="50">
                    </el-table-column>
                    <el-table-column
                        prop="startPayment"
                        label="账单开始时间"
                        width="180"
                        :formatter="dateFormatter"
                        >
                    </el-table-column>
                    <el-table-column
                        prop="endPayment"
                        label="账单结束时间"
                        width="180"
                        :formatter="dateFormatter"
                        >
                    </el-table-column>
                    <el-table-column
                        prop="deadline"
                        label="账单收款日"
                        :formatter="dateFormatter"
                        >
                    </el-table-column>
                    <el-table-column
                        prop="tenantMoney"
                        label="租金（元）">
                    </el-table-column>
                    <el-table-column
                        prop="status"
                        label="状态">
                        <template slot-scope="scope">
                            <span v-if="scope.row.status == 1">已逾期</span>
                            <span v-if="scope.row.status == 0">未逾期</span>
                        </template>
                    </el-table-column>
                    <el-table-column
                        prop="remark"
                        label="备注">
                    </el-table-column>
                </el-table>
            </div>

            <!-- 分页 -->
            <div class="pagination">
                <span></span>
                <el-pagination
                    layout="prev, pager, next"
                    :total="5"
                    :page-size="5"
                    >
                </el-pagination>
               
            </div>
            

            <!-- 底部按钮 -->
            <el-row class="foot-btn">
                <el-button
                    size="mini"
                    @click="goback"
                    >
                    返回
                </el-button>
                <el-button 
                    type="primary"
                    size="mini"
                    >
                    打印
                </el-button>
            </el-row>
        </div>
    </div>
</template>

<script>
import { billPreview } from '../../../../api/asset/contract';
export default{
    name:"bill-detail",
    props:{
        contractId:Number,
    },
    data(){
        return{
            billData:[]
        }
    },
    created(){
        this.getBillDetail();
    },
    methods:{
        //预览账单详情
        getBillDetail(){
            const queryData={
                contractId:this.contractId
            }
            billPreview(queryData).then(res=>{
                console.log('账单预览详情',res);
                this.billData = [res.data];
            }).catch(()=>{

            })
        },

         dateFormatter(row, column, cellValue) {
            if (!cellValue) return '';
            
            // 方法1：直接截取前10个字符（yyyy-MM-dd）
            return cellValue.substring(0, 10);
        },

        goback(){
            this.$router.push({
                path:'/assetManagement/contract'
            })
        }
    }
}
</script>

<style lang="scss" scoped>
.rental-venue-info{
    padding: 20px;
    .rental-venue-content{
        margin:20px 0px;    
    }

    .pagination{
        display: flex;
        justify-content: space-between;
        margin-bottom: 60px;
    }

    .foot-btn{
        display: flex;
        justify-content: center;
    }
}
</style>