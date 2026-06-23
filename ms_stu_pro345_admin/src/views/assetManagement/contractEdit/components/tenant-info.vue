<template>
    <div class="tenant-info-container">

        <!-- 基础信息 -->
        <div class="contract-info-form">
            <el-form 
                :model="tenantInfoForm"
                label-width="120px" 
                size="mini"
                >
                <!-- 合同名称 -->
                <el-form-item 
                    label="合同名称："
                    >
                    <el-input
                        placeholder="请输入合同名称"
                        v-model="tenantInfoForm.contractName"
                        >
                    </el-input>
                </el-form-item>

                <!-- 合同号 -->
                <el-form-item 
                    label="合同号：">
                    <el-input 
                        disabled
                        v-model="tenantInfoForm.contractNum"
                        >
                    </el-input>
                </el-form-item>

                <el-form-item 
                    label="备注（可选）："
                    >
                    <el-input
                        type="textarea"
                        :rows="4"
                        placeholder="请输入备注"
                        v-model="tenantInfoForm.remark"
                        >
                    </el-input>
                </el-form-item>
            </el-form>
        </div>

        <!-- 分界线 -->
        <el-divider content-position="left">乙方</el-divider>

        <!-- 导入租户信息按钮 -->
        <div class="tenant-info-btn">
            <el-button 
                type="primary"
                size="mini"
                icon="el-icon-plus"
                @click="getRentList"
                >
                导入租户信息
            </el-button>
        </div>

        <!-- 租户信息列表 -->
        <el-dialog 
            title="导入租户信息" 
            :visible.sync="dialogRentVisible"
            class="rent-table"
            size="mini"
            width="60%"
            >

            <!-- 租户查询功能 -->
            <el-form 
                :inline="true"
                >
                <!-- 租户名称 -->
                <el-form-item
                    class="el-form-item-gap"
                    size="mini" 
                    label="租户名称："  
                    >
                    <el-input 
                        placeholder="请输入租户名称"
                        v-model="tenantSearchForm.nickName"
                        >
                    </el-input>
                </el-form-item>
                
                <!-- 联系电话 -->
                <el-form-item
                    class="el-form-item-gap"
                    size="mini" 
                    label="联系电话："  
                    >
                    <el-input 
                        placeholder="请输入联系电话"
                        v-model="tenantSearchForm.phonenumber"
                        >
                    </el-input>
                </el-form-item>
                

                <!-- 查询重置 -->
                <el-form-item 
                    class="el-form-item-gap"
                    size="mini">
                    <el-radio-group>
                        <el-button 
                            type="primary"
                            size="mini"
                            @click="searchTenant"
                            >
                            查询
                        </el-button>
                        <el-button
                            size="mini"
                            @click="resetTenantForm"
                            >
                            重置
                        </el-button>
                    </el-radio-group>
                </el-form-item>
            </el-form>
            
            <!-- 表格 -->
            <el-table
                ref="floorTable"
                :data="tenantData"
                tooltip-effect="dark"
                style="width: 100%"
                @current-change="handleCurrentRentRowChange"
                size="mini"
                v-loading="renttableloading"
                element-loading-text="数据加载中"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255,1)"
                highlight-current-row
                >

                <!-- 租户名称 -->
                <el-table-column
                    prop="nickName"
                    label="租户名称"
                    show-overflow-tooltip
                    >
                </el-table-column>

                <!-- 身份证号 -->
                <el-table-column
                    prop="idNum"
                    label="身份证号"
                    show-overflow-tooltip
                    >
                </el-table-column>

                <!-- 邮箱 -->
                <el-table-column
                    prop="email"
                    label="邮箱"
                    show-overflow-tooltip
                    >
                </el-table-column>

                <!-- 家庭住址 -->
                <el-table-column
                    prop="address"
                    label="家庭住址"
                    show-overflow-tooltip
                    >
                </el-table-column>

                <!-- 联系电话 -->
                <el-table-column
                    prop="phonenumber"
                    label="联系电话"
                    show-overflow-tooltip
                    >
                </el-table-column>
            </el-table>

            <!-- 分页区域 -->
            <div class="pagination">
                <span></span>
                <!-- 分页器 -->
                <el-pagination
                    layout="prev, pager, next"
                    :total="tenantTotal"
                    @current-change="handleCurrentRentChange"
                    >
                </el-pagination>
            </div>

            <!-- 底部栏 -->
            <div 
                slot="footer" 
                >
                <!-- 取消按钮 -->
                <el-button 
                    @click="dialogRentVisible = false"
                    size="mini"
                    >
                    取 消
                </el-button>
                <!-- 确定按钮 -->
                <el-button 
                    type="primary" 
                    @click="setTenantInfo"
                    size="mini"
                    >
                    确 定
                </el-button>
            </div>
        </el-dialog>

        <!-- 乙方信息 -->
        <div class="tenat-info-container">
            <el-form 
                label-width="120px"
                size="mini"
                :model="partyBInfo"
                >

                <!-- 租户名称 -->
                <el-form-item 
                    label="租户名称：">
                    <el-input
                        placeholder="请输入租户名称"
                        v-model="partyBInfo.nickName"
                        :disabled="computedDisabled"
                        >
                    </el-input>
                </el-form-item>

                <!-- 身份证号 -->
                <el-form-item 
                    label="身份证号：">
                    <el-input 
                        placeholder="请输入身份证号"
                        v-model="partyBInfo.idNum"
                        :disabled="computedDisabled"
                        >
                    </el-input>
                </el-form-item>

                <!-- 个人邮箱 -->
                <el-form-item 
                    label="个人邮箱：">
                    <el-input
                        placeholder="请输入个人邮箱"
                        v-model="partyBInfo.email"
                        :disabled="computedDisabled"
                        >
                    </el-input>
                </el-form-item>

                <!-- 联系电话 -->
                <el-form-item 
                    label="联系电话：">
                    <el-input 
                        placeholder="请输入联系电话"
                        v-model="partyBInfo.phonenumber"
                        :disabled="computedDisabled"
                        >
                    </el-input>
                </el-form-item>

                <!-- 家庭地址 -->
                <el-form-item 
                    label="家庭地址：">
                    <el-input
                        placeholder="请输入家庭地址"
                        v-model="partyBInfo.address"
                        :disabled="computedDisabled"
                        >
                    </el-input>
                </el-form-item>
            </el-form>
        </div>
        
        <!-- 分界线 -->
        <el-divider content-position="left">选择租赁信息</el-divider>

        <!-- 选择房间按钮 -->
        <div class="room-info-btn">
            <el-button 
                type="primary"
                size="mini"
                icon="el-icon-plus"
                @click="getRoomList"
                >
                选择房间
            </el-button>
        </div>

        <!-- 房间信息列表 -->
        <el-dialog 
            title="选择房间" 
            :visible.sync="dialogRoomVisible"
            class="rent-table"
            size="mini"
            width="60%"
            >

            <!-- 房间查询功能 -->
            <el-form 
                :inline="true"
                >
                <!-- 房间名称 -->
                <el-form-item
                    class="el-form-item-gap"
                    size="mini" 
                    label="房间名称："  
                    >
                    <el-input 
                        placeholder="请输入房间名称"
                        v-model="roomSearchForm.roomName"
                        >
                    </el-input>
                </el-form-item>
                
                <!-- 所属楼宇 -->
                <el-form-item
                    class="el-form-item-gap"
                    size="mini" 
                    label="所属楼宇："  
                    >
                    <el-input 
                        placeholder="请输入所属楼宇"
                        v-model="roomSearchForm.buildingName"
                        >
                    </el-input>
                </el-form-item>
                
                <!-- 查询重置 -->
                <el-form-item 
                    class="el-form-item-gap"
                    size="mini">
                    <el-radio-group>
                        <el-button 
                            type="primary"
                            size="mini"
                            @click="searchRoom"
                            >
                            查询
                        </el-button>
                        <el-button
                            size="mini"
                            @click="resetRoomForm"
                            >
                            重置
                        </el-button>
                    </el-radio-group>
                </el-form-item>
            </el-form>
            
            <!-- 表格 -->
            <el-table
                ref="floorTable"
                :data="roomDataList"
                tooltip-effect="dark"
                style="width: 100%"
                @current-change="handleCurrentRoomRowChange"
                size="mini"
                v-loading="roomtableloading"
                element-loading-text="数据加载中"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255,1)"
                highlight-current-row
                >

                <!-- 房间名称 -->
                <el-table-column
                    prop="roomName"
                    label="房间名称"
                    show-overflow-tooltip
                    >
                </el-table-column>

                <!-- 所属园区 -->
                <el-table-column
                    prop="parkName"
                    label="所属园区"
                    show-overflow-tooltip
                    >
                </el-table-column>

                <!-- 所属楼宇 -->
                <el-table-column
                    prop="buildingName"
                    label="所属楼宇"
                    show-overflow-tooltip
                    >
                </el-table-column>

                <!-- 所属楼层 -->
                <el-table-column
                    prop="floorName"
                    label="所属楼层"
                    show-overflow-tooltip
                    >
                </el-table-column>

                <!-- 出租面积（平方米） -->
                <el-table-column
                    prop="area"
                    label="出租面积（平方米）"
                    show-overflow-tooltip
                    >
                </el-table-column>

                <!-- 租金类型 -->
                <el-table-column
                    prop="tenantMoneyType"
                    label="租金类型"
                    show-overflow-tooltip
                    :formatter="formatRentType"
                    >
                </el-table-column>

                <!-- 租金（元） -->
                <el-table-column
                    prop="tenantMoney"
                    label="租金（元）"
                    show-overflow-tooltip
                    >
                </el-table-column>
            </el-table>

            <!-- 分页区域 -->
            <div class="pagination">
                <span></span>
                <!-- 分页器 -->
                <el-pagination
                    layout="prev, pager, next"
                    :total="roomTotal"
                    @current-change="handleCurrentRoomChange"
                    >
                </el-pagination>
            </div>

            <!-- 底部栏 -->
            <div 
                slot="footer" 
                >
                <!-- 取消按钮 -->
                <el-button 
                    @click="dialogRoomVisible = false"
                    size="mini"
                    >
                    取 消
                </el-button>
                <!-- 确定按钮 -->
                <el-button 
                    type="primary" 
                    @click="setRoomInfo"
                    size="mini"
                    >
                    确 定
                </el-button>
            </div>
        </el-dialog>

        <!-- 选择房间 -->
        <div class="room-select-table-container">
            <el-table
            :data="roomSetInfo"
            style="width: 100%">
            <!-- 房间名称 -->
            <el-table-column
                prop="roomName"
                label="房间名称"
                width="180">
            </el-table-column>

            <!-- 所属园区 -->
            <el-table-column
                prop="parkName"
                label="所属园区"
                width="180">
            </el-table-column>

            <!-- 所属楼宇 -->
            <el-table-column
                prop="buildingName"
                label="所属楼宇">
            </el-table-column>

            <!-- 所属楼层 -->
            <el-table-column
                prop="floorName"
                label="所属楼层">
            </el-table-column>

            <!-- 收租面积(平方米) -->
            <el-table-column
                prop="area"
                label="收租面积(平方米)">
            </el-table-column>
            
            </el-table>
        </div>

        <div class="foot">
            <el-button
                size="mini"
                @click="toContractManage"
                >
                返回
            </el-button>
            <el-button 
                type="primary"
                size="mini"
                @click="sendDataToParent"
                >
                下一步
            </el-button>
        </div>
        
    </div>
</template>

<script>
import { contractRoomList,contractTenantList,contractNum } from '../../../../api/asset/contract';
import { listRenterId } from '../../../../api/renter/tenant';
export default{
    name:'tenant-info',
    props: {
        userId: Number,
        contractId:String,
        contractName:String,
        roomPreviewVo:Object,
        status:String,
    },
    data(){
        return{
            tenantInfoForm:{
                contractName: "",//合同名称
                contractNum: "",//合同编号
                remark: "",//备注
            },
            dialogRentVisible:false,//导入租户弹窗表单显隐控制
            renttableloading:true,//加载
            tenantSearchForm:{
                pageNum:1,
                pageSize:10,
                nickName:'',
                phonenumber:''
            },//租户查询表单
            tenantTotal:0,
            tenantData:[],
            tenantCurrentRow: {},
            partyBInfo:{},//乙方信息
            ifPartyB:false,
            dialogRoomVisible:false,
            roomtableloading:true,
            roomDataList:[],//房间列表信息存储
            roomSearchForm:{
                pageNum:1,
                pageSize:5,
                buildingName:'',
                roomName:''
            },//房间查询表单
            roomTotal:0,
            roomCurrentRow: {},//选择房间信息
            roomSetInfo:[],//租赁房间信息
            
        }
    },
    computed:{
        computedDisabled() {
            // 多种条件组合
            return this.ifPartyB
        },
        
    },
    watch:{
        status: {
            handler(newVal, oldVal) {
                if (newVal == 'add') {  //新增合同模式下自动生成合同编号
                    this.getContractNum();
                }
            },
            immediate: true  // 立即执行一次
        },
        userId(newVal, oldVal) {
            this.getRentInfoId();
        },
        contractId: {
            handler(newVal, oldVal) {
                if (newVal) {  // 添加非空判断
                    console.log('合同编号', newVal);
                    this.$set(this.tenantInfoForm, 'contractNum', newVal);
                }
            },
            immediate: true  // 立即执行一次
        },
        contractName: {
            handler(newVal, oldVal) {
                if (newVal) {  // 添加非空判断
                    console.log('合同编号', newVal);
                    this.$set(this.tenantInfoForm, 'contractName', newVal);
                }
            },
            immediate: true  // 立即执行一次
        },
        roomPreviewVo: {
            handler(newVal, oldVal) {
                if (newVal) {  // 添加非空判断
                    console.log('合同编号', newVal);
                    const {area,buildingName,floorName,roomName,parkName,roomId} = newVal
                    this.roomSetInfo = [{area,buildingName,floorName,roomName,parkName,roomId}];
                    const data = {
                        area:newVal.area
                    };
                    this.$emit('area-event', data);
                }
            },
            immediate: true  // 立即执行一次
        },

    },
    methods:{
        //向父组件传递显示信息（下一步事件）
        sendDataToParent() {
            switch(this.status){
                case 'add':
                    const tenantInfoAdd = { 
                        contractName:this.tenantInfoForm.contractName,
                        contractNum:this.tenantInfoForm.contractNum,
                        remark:this.tenantInfoForm.remark,
                        tenantId:this.partyBInfo.userId,
                        roomId:this.roomCurrentRow.roomId,
                    };
                    this.$emit('tenantinfo-event', tenantInfoAdd);
                    break;
                case 'edit':
                    const tenantInfoEdit = { 
                        contractId:this.contractId,
                        contractName:this.tenantInfoForm.contractName,
                        contractNum:this.tenantInfoForm.contractNum,
                        remark:this.tenantInfoForm.remark,
                        tenantId:this.partyBInfo.userId,
                        roomId:this.roomSetInfo[0].roomId,
                    };
                    this.$emit('tenantinfo-event', tenantInfoEdit);
                    break;
                case 'change':
                    const tenantInfoChange = { 
                        contractId:this.contractId,
                        contractName:this.tenantInfoForm.contractName,
                        contractNum:this.tenantInfoForm.contractNum,
                        remark:this.tenantInfoForm.remark,
                        tenantId:this.partyBInfo.userId,
                        roomId:this.roomSetInfo[0].roomId,
                    };
                    this.$emit('tenantinfo-event', tenantInfoChange);
                    break;
                default:
            }
            const data = {
                active:1
            };
            this.$emit('tenant-event', data);
            
            window.scrollTo({
                top: 0,
                behavior: 'smooth' // 平滑滚动
            });  
        },

        //自动生成合同编号
        getContractNum(){
            contractNum().then(res=>{
                console.log(res);
                this.$set(this.tenantInfoForm, 'contractNum', res.data);
            }).catch(()=>{

            })
        },

        //获取租户信息列表
        getRentList(){
            this.dialogRentVisible = true;
            const queryData = this.tenantSearchForm;
            this.renttableloading = true;
            contractTenantList(queryData).then(res=>{
                this.tenantTotal = res.total;
                this.tenantData = res.list;
                this.renttableloading = false;
            }).catch(()=>{

            })
        },

        //根据租户id获取租户信息
        getRentInfoId(){
            const userId = this.userId
            listRenterId(userId).then(res=>{
                const { nickName,idNum,email,phonenumber,address } = res.data
                // 分别设置每个属性
                this.$set(this.partyBInfo, 'nickName', nickName)
                this.$set(this.partyBInfo, 'idNum', idNum)
                this.$set(this.partyBInfo, 'email', email)
                this.$set(this.partyBInfo, 'phonenumber', phonenumber)
                this.$set(this.partyBInfo, 'address', address)
                this.$set(this.partyBInfo, 'userId', userId)
                this.ifPartyB = true;
            }).catch(res=>{
                
            })
        },

        //查询租户信息
        searchTenant(){
            this.getRentList();
        },

        //重置查询租户表单
        resetTenantForm(){
            this.tenantSearchForm.nickName = '';
            this.tenantSearchForm.phonenumber = '';
            this.getRentList();
        },

        //选择租户信息
        handleCurrentRentRowChange(val){
            this.tenantCurrentRow = val;
            console.log(val);
        },

        //分页切换页
        handleCurrentRentChange(val) {
            this.tenantSearchForm.pageNum = val;
            this.getRentList();
        },

        //导入租户信息
        setTenantInfo(){
            this.partyBInfo = this.tenantCurrentRow;
            this.tenantInfo = {...this.tenantCurrentRow};
            this.ifPartyB = true;
            this.dialogRentVisible = false;
        },

        //获取房间信息分页
        getRoomList(){
            this.dialogRoomVisible = true;
            this.roomtableloading = true;
            const queryData  = this.roomSearchForm;
            contractRoomList(queryData).then(res=>{
                console.log(res);
                this.roomDataList = res.list;
                this.roomtableloading = false;
                this.roomTotal = res.total;
            }).catch(()=>{

            })
        },

        //查询房间信息
        searchRoom(){
            this.getRoomList();
        },

        //重置查询房间表单
        resetRoomForm(){
            this.roomSearchForm.buildingName = '';
            this.roomSearchForm.roomName = '';
            this.getRoomList();
        },

        //选择房间信息
        handleCurrentRoomRowChange(val){
            this.roomCurrentRow = val;
            this.tenantInfo = {...val}
            console.log(val);
        },

        //房间分页切换页
        handleCurrentRoomChange(val) {
            this.roomSearchForm.pageNum = val;
            this.getRoomList();
        },

        //导入房间信息
        setRoomInfo(){
            this.roomSetInfo = [this.roomCurrentRow];
            this.dialogRoomVisible = false;
            console.log(this.roomSetInfo);
            
            const data = {
                area:this.roomCurrentRow.area
            };

            this.$emit('area-event', data);
        },

        //字典映射
        formatRentType(row, column, cellValue) {
            const rentTypeMap = {
                1: '元/m²/天',
                2: '元/m²/月',
                3: '元/天',
                4: '元/月'
            };
            return rentTypeMap[cellValue] || cellValue;
        },

        // 返回合同界面
        toContractManage(){
            this.$router.push({
                path:'/assetManagement/contract'
            })
        }

    }
}
</script>

<style lang="scss" scoped>
.tenant-info-container{

    //合同信息
    .contract-info-form{
        margin: 0 200px;
        box-sizing: border-box;
    }

    //导入租户信息按钮
    .tenant-info-btn{
        margin-bottom: 10px;
    }

    //租户信息列表
    .rent-table{

        .el-form-item-gap{
            margin-right: 20px;
        }

        .pagination{
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        
    }

    //乙方信息
    .tenat-info-container{
        margin: 0 200px;
        box-sizing: border-box;
    }

    //选择房间信息按钮
    .room-info-btn{
        margin-bottom: 10px;
    }

    //底部按钮
    .foot{
        margin-top: 20px;
        display: flex;
        justify-content: center;
    }
}
</style> 