<template>
    <div class="room-container">
        <!-- 标题 -->
        <div class="title">
            房间详情
        </div>
        
        <!-- 表单区域 -->
        <div class="form-container">

            <div class="form-content">
                <el-form 
                    ref="roomForm"
                    :model="roomDetailForm" 
                    label-width="180px"
                    label-position="right"
                    >

                    <!-- 所属楼宇 -->
                    <el-form-item 
                        label="所属楼宇："
                        prop="buildingId">
                        <el-select 
                            v-model="roomDetailForm.buildingId"
                            placeholder="暂无"
                            disabled
                            >
                            <el-option 
                                v-for="item in buildingNameList" 
                                :label="item.buildingName" 
                                :value="item.buildingId"
                                >
                            </el-option>
                        </el-select>
                    </el-form-item>

                    <!-- 所属楼层 -->
                    <el-form-item 
                        label="所属楼层："
                        prop="floorName"
                        >
                        <el-select 
                            v-model="roomDetailForm.floorName"
                            placeholder="暂无"
                            disabled
                            >
                            <el-option 
                                v-for="item in floorNameList" 
                                :label="item.floorName" 
                                :value="item.floorId"
                                >
                            </el-option>
                        </el-select>
                    </el-form-item>

                    <!-- 房间名称 -->
                    <el-form-item 
                        label="房间名称："
                        prop="roomName"
                        >
                        <el-input 
                            v-model="roomDetailForm.roomName"
                            style="width: 180px;"
                            placeholder="暂无"
                            disabled
                            >
                        </el-input>
                    </el-form-item>

                    <!-- 租金 -->
                    <el-form-item 
                        label="租金："
                        prop="tenantMoney"
                        >
                        <el-input
                            v-model="roomDetailForm.tenantMoney"
                            placeholder="暂无"
                            class="input"
                            disabled
                            >
                            <el-select
                                v-model="roomDetailForm.tenantMoneyType"
                                slot="append"
                                placeholder="请选择"
                                class="select"
                                disabled
                                >
                                <el-option
                                    v-for="item in dict.type.rent_type"
                                    :label="item.label" 
                                    :value="item.value"
                                    >
                                </el-option>
                            </el-select>
                        </el-input>
                        
                    </el-form-item>

                    <!-- 物业费 -->
                    <el-form-item 
                        label="物业费："
                        prop="money"
                        >
                        <el-input
                            v-model="roomDetailForm.money"
                            placeholder="暂无"
                            class="input"
                            disabled
                            >
                            <el-select
                                v-model="roomDetailForm.moneyType"
                                slot="append"
                                placeholder="暂无"
                                class="select"
                                disabled
                                >
                                <el-option
                                    v-for="item in dict.type.rent_type"
                                    :label="item.label" 
                                    :value="item.value"
                                    >
                                </el-option>
                            </el-select>
                        </el-input>
                    </el-form-item>

                    <!-- 房间面积（平方米） -->
                    <el-form-item
                        label="房间面积（平方米）："
                        prop="area"
                        >
                        <el-input 
                            v-model="roomDetailForm.area"
                            style="width: 180px;"
                            placeholder="暂无"
                            disabled
                            >
                        </el-input>
                    </el-form-item>

                    <!-- 房型 -->
                    <el-form-item 
                        label="房型："
                        prop="roomType"
                        >
                        <el-select 
                            v-model="roomDetailForm.roomType"
                            disabled
                            >
                            <el-option label="loft" value="1"></el-option>
                            <el-option label="商业配套" value="2"></el-option>
                            <el-option label="办公场所" value="3"></el-option>
                            <el-option label="其他" value="4"></el-option>
                        </el-select>
                    </el-form-item>

                    <!-- 房高 -->
                    <el-form-item 
                        label="房高："
                        prop="roomHeight"
                        >
                        <el-input 
                            v-model="roomDetailForm.roomHeight"
                            style="width: 180px;"
                            placeholder="暂无"
                            disabled
                            >
                        </el-input>
                    </el-form-item>

                    <!-- 装修类型 -->
                    <el-form-item 
                        label="装修类型："
                        prop="tenantMoney"
                        >
                        <el-select 
                            v-model="roomDetailForm.renovationType" 
                            disabled
                            >
                            <el-option label="简装" value="1"></el-option>
                            <el-option label="精装" value="2"></el-option>
                            <el-option label="毛坯" value="3"></el-option>
                        </el-select>
                    </el-form-item>

                    <!-- 房间小图 -->
                    <el-form-item label="房间小图：">
                        <el-upload
                            action="#"
                            list-type="picture-card"
                            :file-list="imageFileList"
                            :disabled="true"
                        >
                            <i slot="default" class="el-icon-plus"></i>
                        </el-upload>
                        <el-dialog :visible.sync="dialogVisible">
                            <img width="100%" :src="dialogImageUrl" alt="">
                        </el-dialog>
                    </el-form-item>

                    <!-- 房间简介 -->
                    <el-form-item label="房间简介：">
                        <el-input 
                            type="textarea" 
                            :rows="4"
                            v-model="roomDetailForm.introduce"
                            disabled
                            >
                        </el-input>
                    </el-form-item>
                </el-form>
            </div>     
        </div>
    </div>
</template>
<script>
import { listBuildingName } from '../../../api/park/building';
import { listFloorName } from '../../../api/park/floor';
import { addRoom,editRoom,roomDetail } from '../../../api/park/room';
    export default{
        dicts:['rent_type','room-type'],
        name:"roomDetail",
        data(){
            return{
                formStatus:'',//表单状态（编辑/新建）
                buildingNameList:[],//楼宇名称
                floorNameList:[],//楼层名称
                currentRoomId:undefined,//当前房间Id

                imageFileList: [],   // 用于 el-upload 显示图片列表
                disabled: true,      // 整个组件设为只读（已有，确保为 true）

                //新增房间
                roomDetailForm: {
                    area: null,
                    buildingId: null,
                    floorId:null,
                    introduce:'',
                    money:null,//物业费
                    moneyType:'',
                    renovationType:'',
                    roomHeight:null,
                    roomImage:[],
                    roomName:'',
                    roomType:'',
                    tenantMoney:null,
                    tenantMoneyType:'',
                },//房间详情表单
                dialogImageUrl: '',
                dialogVisible: false,
            } 
        },
        created(){
            this.initPage();
        },
        methods:{
            //初始化页面
            initPage(){
                this.currentRoomId = this.$route.query.roomId;
                
                // 2. 获取楼宇列表（可以和下一步并行，但这里保持简单）
                this.getBuildingNameList();
                
                this.$nextTick(() => {
                    this.getRoomDetail();
                });
            },

            //获取楼宇名称列表
            getBuildingNameList(){
                listBuildingName().then(res=>{
                    this.buildingNameList = res.data;   
                }).catch(()=>{

                })
            },

            //获取楼层名称列表
            getFloorNameList(val){
                listFloorName(val).then(res=>{
                    this.floorNameList= res.data;
                }).catch(()=>{

                })
            },

            fixImageUrl(url) {
                if (!url) return '';
                if (url.includes('127.0.0.1:11345')) {
                    return url.replace('http://127.0.0.1:11345', 'http://mashang.eicp.vip:5555/ms_stu_pro345');
                }
                if (url.startsWith('/profile')) {
                    return `http://mashang.eicp.vip:5555/ms_stu_pro345${url}`;
                }
                return url;
            },

            //房间详情（回显）
            getRoomDetail() {
                if (!this.currentRoomId) {
                    this.currentRoomId = this.$route.query.roomId;
                    if (!this.currentRoomId) return;
                }
                roomDetail(this.currentRoomId).then(res => {
                    console.log(res);
                    
                    this.roomDetailForm = res.data;
                    // 处理图片回显
                    const images = res.data.roomImage || [];
                    this.imageFileList = images.map((url, idx) => ({
                        uid: Date.now() + idx,
                        name: `image_${idx + 1}`,
                        url: this.fixImageUrl(url)   // 需要实现该方法
                    }));
                }).catch(error => {
                    console.error('获取详情失败:', error);
                });
            },

            //表单验证
            onSubmit() {
                console.log('submit!');
            },
            handleRemove(file) {
                console.log(file);
            },
            handlePictureCardPreview(file) {
                this.dialogImageUrl = file.url;
                this.dialogVisible = true;
            },
            handleDownload(file) {
                console.log(file);
            },
        },
        watch:{
            'roomDetailForm.buildingId':{
                handler(newVal, oldVal){
                    if(this.formStatus =='add') {
                        this.roomDetailForm.floorId = null;
                        this.getFloorNameList(newVal);
                    }
                },
                immediate: true
            }
        }
    }
</script>

<style lang="scss" scoped>

.room-container{
    box-sizing: border-box;
    background-color: #f1f2f6;

    // 大字标题样式
    .title{
        font-size: 18px;
        font-weight: bold;
        background-color: white;
        padding:20px 15px;
    }

    .form-container{
        box-sizing: border-box;
        padding: 20px;
        background-color: #f1f2f6;
        
        .form-content{
            background-color: white;
            padding: 20px 150px;
            box-sizing: border-box;

            .tip{
                color: #606266;
                font-size: 12px;
            }
        }
    }
}
.select{
    width: 100px;
}
.input{
    width: 280px;
}
</style>