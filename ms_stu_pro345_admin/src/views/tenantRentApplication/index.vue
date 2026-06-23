<template>
    <div class="my-rent-container">
        <!-- 标题 -->
        <div class="title">
            租房申请
        </div>

        <div class="rent-container">
            <div class="rent-content">
            
                <!-- 查询功能 -->
                <el-form 
                    :inline="true"
                    class="search-content"
                    >
                    <!-- 房间名称 -->
                    <el-form-item
                        class="el-form-item-gap"
                        size="mini" 
                        label="房间名称："  
                        >
                        <el-input 
                            placeholder="请输入房间名称"
                            v-model="roomName"
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
                            placeholder="请输入所属楼宇名称"
                            v-model="buildingName"
                            >
                        </el-input>
                    </el-form-item>

                    <!-- 所属园区 -->
                    <el-form-item
                        class="el-form-item-gap"
                        size="mini" 
                        label="园区名称："  
                        >
                        <el-input 
                            placeholder="请输入所属园区名称"
                            v-model="parkName"
                            >
                        </el-input>
                    </el-form-item>

                    <!-- 查询与重置 -->
                    <el-form-item 
                        class="el-form-item-gap"
                        size="mini">
                        <el-radio-group>
                            <el-button 
                                type="primary"
                                size="mini"
                                @click="searchRent()"
                                >
                                查询
                            </el-button>
                            <el-button
                                size="mini"
                                @click="resetForm()"
                                >
                                重置
                            </el-button>
                        </el-radio-group>
                    </el-form-item>
                </el-form>

                <!-- 表格数据 -->
                <el-table
                    size="mini"
                    ref="multipleTable"
                    :data="myRentData"
                    tooltip-effect="dark"
                    style="width: 100%"
                    v-loading="rentTableloading"
                    element-loading-text="数据加载中"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255,1)"
                    >

                    <el-table-column
                        prop="parkName"
                        label="所属园区"
                        width="120">
                    </el-table-column>

                    <el-table-column
                        prop="roomName"
                        label="房间名称"
                        width="120">
                    </el-table-column>

                    <el-table-column
                        prop="buildingName"
                        label="所属楼宇"
                        width="120"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="floorName"
                        label="所属楼层"
                        width="120"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="area"
                        label="面积（平方米）"
                        width="120"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="tenantMoney"
                        label="租金（元）"
                        width="120"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="tenantMoneyType"
                        label="租金类型"
                        width="300"
                        :formatter="formatRentType"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="address"
                        label="操作"
                        >
                        <template slot-scope="scope">
                            <el-button 
                                type="text"
                                size="mini"
                                @click="handleRent(scope.row)"
                            >
                                租赁
                            </el-button>
                            <el-button 
                                type="text"
                                size="mini"
                                @click="readRoomDetail(scope.row.roomId)"
                            >
                                详情
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

                <!-- 个人信息弹窗 -->
                <div class="info-dialog-container">
                    <el-dialog 
                        title="信息确认" 
                        :visible.sync="rentDialogVisible"
                        width="40%"
                        >
                        <div class="tips">
                            <span>确认个人信息,若有误请从个人中心修改</span>
                        </div>
                        <el-form 
                            label-width="80px" 
                            :model="tenantForm"
                            size="mini"
                            >
                            <el-form-item label="真实姓名">
                                <el-input
                                    v-model="tenantForm.nickName"
                                    disabled
                                    >
                                </el-input>
                            </el-form-item>
                            <el-form-item label="身份证号">
                                <el-input
                                    v-model="tenantForm.idNum"
                                    disabled
                                    >
                                </el-input>
                            </el-form-item>
                            <el-form-item label="个人邮箱">
                                <el-input
                                    v-model="tenantForm.email"
                                    disabled
                                    >
                                </el-input>
                            </el-form-item>
                            <el-form-item label="联系电话">
                                <el-input
                                    v-model="tenantForm.phonenumber"
                                    disabled
                                    >
                                </el-input>
                            </el-form-item>
                            <el-form-item label="家庭地址">
                                <el-input
                                    v-model="tenantForm.address"
                                    disabled
                                    >
                                </el-input>
                            </el-form-item>
                        </el-form>
                        <div class="tips">
                            <span>是否确定申请租赁"{{rentRoomInfo}}"?</span>
                        </div>
                        <div slot="footer" class="dialog-footer">
                            <el-button 
                                @click="rentDialogVisible = false"
                                size="mini"
                                >
                                取 消
                            </el-button>
                            <el-button 
                                type="primary" 
                                @click="toSelectTime"
                                size="mini"
                                >
                                确 定
                            </el-button>
                        </div>
                    </el-dialog>
                </div>

                <div class="time-dialog-container">
                    <el-dialog 
                        title="请选择起始租日" 
                        :visible.sync="rentTimeDialogVisible"
                        width="40%"
                        size="mini"
                        >
                        <el-date-picker
                            v-model="starOverTime"
                            type="daterange"
                            range-separator="至"
                            start-placeholder="开始日期"
                            end-placeholder="结束日期"
                            >
                        </el-date-picker>
                        <div slot="footer" class="dialog-footer">
                            <el-button 
                                @click="rentTimeDialogVisible = false"
                                size="mini"
                                >
                                取 消
                            </el-button>
                            <el-button 
                                type="primary" 
                                @click="handleApplication"
                                size="mini"
                                >
                                确 定
                            </el-button>
                        </div>
                    </el-dialog>
                </div>
            
            </div>
        </div>
        
    </div>
    
</template>
<script>
import { listMyRent,tenantInfo,rentApply } from '../../api/tenant/rent';
    export default{
        name:"my-rent",
        components:{},
        data(){
            return{
                myRentData: [],//租赁申请表格数据
                pageNum:1,
                pageSize:5,
                buildingName:'',
                parkName:'',
                roomName:'',
                total:0,
                rentTableloading:true,
            
                rentDialogVisible:false,//指派员工显隐控制
                tenantForm:{
                    nickName:'',
                    idNum:'',
                    email:'',
                    phonenumber:'',
                    address:'', 
                    roomStatus:'',
                },
                rentRoomInfo:'',
                rentTimeDialogVisible:false,
                rentApply:{
                    endTime:'',
                    roomId:'',
                    startTime:''
                },
                starOverTime:[]
            } 
        },
        created(){
            this.getMyRentList();
            
        },
        methods:{
            //获取租赁详情数据
            getMyRentList(){
                this.rentTableloading=true;
                const queryData={
                    pageNum:this.pageNum,
                    pageSize:this.pageSize,
                    buildingName:this.buildingName,
                    parkName:this.parkName,
                    roomName:this.roomName,
                }
                listMyRent(queryData).then(res=>{
                    this.myRentData =res.list;
                    this.total = res.total;
                    this.rentTableloading=false;
                }).catch(()=>{

                })
            },

            //租赁按钮触发事件
            handleRent(row){
                console.log('当前行的详细信息：',row);
                const roomName = row.parkName + row.buildingName + row.floorName + row.roomName;
                this.rentRoomInfo = roomName;
                this.rentApply.roomId = row.roomId;
                this.rentDialogVisible = true;
                tenantInfo().then(res=>{
                    console.log('获取租户信息',res);
                    this.tenantForm.nickName = res.data.realName;
                    this.tenantForm.idNum = res.data.idCard;
                    this.tenantForm.email = res.data.email;
                    this.tenantForm.phonenumber = res.data.phonenumber;
                    this.tenantForm.address = res.data.address;
                    this.tenantForm.roomStatus = res.data.roomStatus;
                }).catch(err=>{

                }) 
            },

            //选择租房起止时间
            toSelectTime(){
                switch(this.tenantForm.roomStatus){
                    case '2':
                        this.$message.error('当前您尚有房源处于未退租状态，故暂时无法进行新房屋的租赁事宜');
                        break;
                    case '1':
                        this.$message.error('当前您尚有房源处于申请租赁状态，故暂时无法进行新房屋的租赁事宜');
                        break;
                    case '0':
                        this.rentDialogVisible = false;
                        this.rentTimeDialogVisible = true;
                    default:
                        break;
                }
            },

            //提交租赁申请
            handleApplication(){
                this.rentTimeDialogVisible = true;
                console.log(this.starOverTime);
                const newDate = this.formatDatesToYMD(this.starOverTime);
                console.log(newDate);
                this.rentApply.endTime = newDate[1];
                this.rentApply.startTime = newDate[0];
                rentApply(this.rentApply).then(res=>{
                    console.log('提交租房申请响应',res);
                    if(res.status == 200){
                        this.$message.success(res.message);
                        this.rentTimeDialogVisible = false;
                        this.starOverTime = [];
                    }else{
                        this.$message.error(res.message);
                    }
                }).catch(()=>{

                })
            },

            //时间格式转换
            formatDatesToYMD(dateArray){
                return dateArray
                .filter(item => item instanceof Date && !isNaN(item)) // 只保留有效的 Date 对象
                .map(date => {
                    const year = date.getFullYear();
                    const month = String(date.getMonth() + 1).padStart(2, '0');
                    const day = String(date.getDate()).padStart(2, '0');
                    const hours = String(date.getHours()).padStart(2, '0');
                    const minutes = String(date.getMinutes()).padStart(2, '0');
                    const seconds = String(date.getSeconds()).padStart(2, '0');
                    return `${year}-${month}-${day}T${hours}:${minutes}:${seconds}`;
                });
            },


            //查询
            searchRent(){
                this.getMyRentList();
                console.log(1);
                
            },

            //重置
            resetForm(){
                this.buildingName=''
                this.parkName=''
                this.roomName=''
                this.getMyRentList();
            },

            //字典映射
            formatRentType(row, column, cellValue) {
                const rentTypeMap = {
                    0: '元/m²/天',
                    1: '元/m²/月',
                    2: '元/天',
                    3: '元/月'
                };
                return rentTypeMap[cellValue] || cellValue;
            },

            //每页条数
            handleSizeChange(val) {
                console.log(`每页 ${val} 条`);
                this.pageSize = val;
                this.getMyRentList();
            },

            //当前页
            handleCurrentChange(val) {
                console.log(`当前页: ${val}`);
                this.pageNum = val;
                this.getMyRentList();
            },

            //查看房屋详情
            readRoomDetail(row){
                this.$router.push({
                    path:"/tenantRentApplicatipn/roomDetailReadOnly",
                    query:{
                        roomId:row
                    }
                })
            }
        }
    }
</script>
<style lang="scss" scoped>
.my-rent-container{
    height: 100%;
    box-sizing: border-box;
    background-color: #f1f2f6;

    //标题样式
    .title{
        padding:20px 15px;
        font-weight: bold;
        background-color: white;
    }

    .rent-container{
        padding: 20px;
        background-color: #f1f2f6;
        box-sizing: border-box;
        font-weight: normal;

        .rent-content{
            padding: 20px;
            background-color: white;
            box-sizing: border-box;

            .search-content{
                margin-bottom: 20px;
            }

            .pagination{
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }

            .info-dialog-container{
                .tips{
                    display: flex;
                    justify-content: center;
                    margin-bottom: 20px;
                }
            }

            .time-dialog-container{
                
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