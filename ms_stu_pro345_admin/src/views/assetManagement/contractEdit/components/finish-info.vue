<template>
    <div class="finish-info-container">
        <el-button 
            type="success" 
            icon="el-icon-check" 
            circle
            size="large"
            
            >
        </el-button>
        <span>
            操作成功
        </span>
        <el-button
            size="mini"
            @click="toContractManage"
            >
            返回
        </el-button>
    </div>
</template>

<script>
export default{
    name:'finish-info',
    data(){
        return{
           
        }
    },
    methods:{
        //去合同界面
        toContractManage(){
            this.$router.push({
                path:'/assetManagement/contract'
            })
        }
    },
}
</script>

<style lang="scss" scoped>
.finish-info-container{
    box-sizing: border-box;
    padding: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 20px;
}
</style>