<template>
    <div class="contract-detail-container">
        <!-- 标题 -->
        <div class="title">
            合同详情
        </div>

        <div class="detail-info-container">
            <div class="detail-info-content">
                <el-tabs v-model="activeName" @tab-click="handleClick">
                    <el-tab-pane label="合同信息" name="first">
                        <contract-detail
                            :contractId="contractId"
                            >
                        </contract-detail>
                    </el-tab-pane>
                    <el-tab-pane label="账单信息" name="second">
                        <bill-detail
                            :contractId="contractId"
                            >
                        </bill-detail>
                </el-tab-pane>    
            </el-tabs>
            </div>
        </div>
       
    </div>
   
</template>

<script>
    import contractDetail from "./components/contract-detail.vue"
    import billDetail from "./components/bill-detail.vue"

    export default{
        name:'contarct-detail-index',
        components:{contractDetail,billDetail},
        data(){
            return{
                activeName: 'first',
                contractId:null,
            }
            
        },
        created(){
            this.initPage();
        },
        methods:{
            //初始化界面
            initPage(){
                this.contractId=Number(this.$route.query.contractId);
                console.log('已收到跳转id',this.contractId);
                
            },
            handleClick(tab, event) {
                console.log(tab, event);
                this.activeName = tab.name;
            }
        }
    }
</script>

<style lang="scss" scoped>
.contract-detail-container{
    
    .title{
        padding:20px 15px;
        font-weight: bold;
        font-weight: 18px;
        background-color: white;
    }

    .detail-info-container{
        padding: 20px;
        background-color: #f1f2f6;
        box-sizing: border-box;
        font-weight: normal;
        

        .detail-info-content{
            box-sizing: border-box;
            background-color: white;
            padding: 20px;
            font-size: 12px;
            color: #5f5f5f;
        
        }
    }
}

</style>