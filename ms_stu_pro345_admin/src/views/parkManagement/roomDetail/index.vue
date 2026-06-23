<template>
    <div class="room-container">
        <!-- 标题 -->
        <div class="title">
            房间编辑
        </div>
        
        <!-- 表单区域 -->
        <div class="form-container">

            <div class="form-content">
                <el-form 
                    ref="roomForm"
                    :model="roomDetailForm" 
                    :rules="roomRules"
                    label-width="180px"
                    label-position="right"
                    >

                    <!-- 所属楼宇 -->
                    <el-form-item 
                        label="所属楼宇："
                        prop="buildingId">
                        <el-select 
                            v-model="roomDetailForm.buildingId"
                            placeholder="请选择"
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
                        prop="floorId"
                        >
                        <el-select 
                            v-model="roomDetailForm.floorId"
                            placeholder="请选择"
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
                            placeholder="请输入房间名称"
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
                            placeholder="租金"
                            class="input"
                            >
                            <el-select
                                v-model="roomDetailForm.tenantMoneyType"
                                slot="append"
                                placeholder="请选择"
                                class="select"
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
                            placeholder="物业费"
                            class="input"
                            >
                            <el-select
                                v-model="roomDetailForm.moneyType"
                                slot="append"
                                placeholder="请选择"
                                class="select"
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
                            placeholder="请输入房间面积"
                            >
                        </el-input>
                    </el-form-item>

                    <!-- 房型 -->
                    <el-form-item 
                        label="房型："
                        prop="roomType"
                        >
                        <el-select v-model="roomDetailForm.roomType">
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
                            placeholder="请输入房高"
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
                            >
                            <el-option label="简装" value="1"></el-option>
                            <el-option label="精装" value="2"></el-option>
                            <el-option label="毛坯" value="3"></el-option>
                        </el-select>
                    </el-form-item>

                    <!-- 上传房间小图 -->
                    <el-form-item label="上传房间小图：">
                    <el-upload
                        ref="upload"  
                        action="http://mashang.eicp.vip:5555/ms_stu_pro345/common/upload"
                        list-type="picture-card"
                        :auto-upload="true"
                        :before-upload="beforeUpload"
                        :on-success="handleSuccess"
                        :on-error="handleError"
                        :on-remove="handleRemove"
                        :headers="uploadHeaders"
                        :file-list="imageFileList"     
                        >
                            <i slot="default" class="el-icon-plus"></i>
                            <div slot="file" slot-scope="{file}">
                                <img
                                    class="el-upload-list__item-thumbnail"
                                    :src="file.url" alt=""
                                >
                                <span class="el-upload-list__item-actions">
                                    <span
                                        class="el-upload-list__item-preview"
                                        @click="handlePictureCardPreview(file)"
                                        >
                                        <i class="el-icon-zoom-in"></i>
                                    </span>
                                    <span
                                        v-if="!disabled"
                                        class="el-upload-list__item-delete"
                                        @click="handleRemove(file)"
                                        >
                                        <i class="el-icon-delete"></i>
                                    </span>
                                </span>
                            </div>
                            <div class="el-upload__tip" slot="tip">只能上传jpg/png文件，且不超过500kb</div>
                        </el-upload>
                        <el-dialog :visible.sync="dialogVisible">
                            <img width="100%" :src="dialogImageUrl" alt="">
                        </el-dialog>
                        <!-- <el-button type="primary" @click="submitUpload">上传到服务器</el-button> -->
                    </el-form-item>

                    <!-- 房间简介 -->
                    <el-form-item label="房间简介（可选）：">
                        <el-input 
                            type="textarea" 
                            :rows="4"
                            v-model="roomDetailForm.introduce">
                        </el-input>
                        <div class="tip">不要超过50个字符</div>
                    </el-form-item>
                </el-form>

                <!-- 操作按钮 -->
                <div slot="footer" class="dialog-footer">
                    <el-button 
                        type="primary" 
                        @click="submitData('roomForm')"
                        >
                        提交
                        </el-button>
                    <el-button 
                        @click="closePage()"
                        >
                        关闭
                    </el-button>
                </div>
            </div>     
        </div>
    </div>
</template>
<script>
import { listBuildingName } from '../../../api/park/building';
import { listFloorName } from '../../../api/park/floor';
import { addRoom,editRoom,roomDetail } from '../../../api/park/room';
import { getToken } from '@/utils/auth'
    export default{
        dicts:['rent_type','room-type'],
        name:"roomDetail",
        data(){
            return{
                token: localStorage.getItem('token') || '',

                formStatus:'',//表单状态（编辑/新建）
                buildingNameList:[],//楼宇名称
                floorNameList:[],//楼层名称
                currentRoomId:undefined,//当前房间Id

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
                // 新增：用于 el-upload 组件显示的 file-list
                imageFileList: [],   // 格式: [{ name: 'xxx.png', url: 'http://...' }]
                roomRules:{
                    buildingId: [{ 
                        required: true, 
                        message: '请选择所属楼宇', 
                        trigger: 'change' 
                    }],
                    floorId: [{ 
                        required: true, 
                        message: '请选择所属楼层', 
                        trigger: 'change' 
                    }],
                    roomName: [{ 
                        required: true, 
                        message: '请输入房间名称', 
                        trigger: 'change' 
                    }],
                    tenantMoney: [{ 
                        required: true, 
                        message: '请填写租金', 
                        trigger: 'change' 
                    }],
                    money: [{ 
                        required: true, 
                        message: '请填写物业费', 
                        trigger: 'change' 
                    }],
                    area: [{ 
                        required: true, 
                        message: '请填写房间面积', 
                        trigger: 'change' 
                    }],
                    roomType: [{ 
                        required: true, 
                        message: '请选择房型', 
                        trigger: 'change' 
                    }],
                    renovationType: [{ 
                        required: true, 
                        message: '请选择装修类型', 
                        trigger: 'change' 
                    }]
                }, 

                dialogImageUrl: '',
                dialogVisible: false,
                disabled: false,
            } 
        },
        created(){
            this.initPage();
        },
        computed:{
            uploadHeaders() {
                const token = getToken()  // 从 Cookie 中读取 Admin-Token
                if (token) {
                    return {
                    Authorization: 'Bearer ' + token
                    }
                }
                return {}
            }
        },
        methods:{
            //初始化页面
            initPage(){
                
                // 1. 先判断状态
                this.formStatusJudge();
                
                // 2. 获取楼宇列表（可以和下一步并行，但这里保持简单）
                this.getBuildingNameList();
                
                // 3. 如果是编辑，获取详情
                if (this.formStatus === 'edit' ) {
                    // 需要等待currentRoomId被设置
                    this.$nextTick(() => {
                        this.getRoomDetail();
                    });
                }

            },

            //表单状态判断
            formStatusJudge(){
                // 直接从路由获取参数
                const { type, roomId } = this.$route.query;
                
                 // 设置表单状态
                if (type && !this.formStatus) {
                    this.formStatus = type;
                }
                // 设置房间ID（如果是编辑）
                 if (this.formStatus === 'edit' && roomId) {
                    this.currentRoomId = roomId;
                }
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
                console.log('当前楼层列表',val);
                listFloorName(val).then(res=>{
                    console.log('当前楼层列表',res);
                    
                    this.floorNameList= res.data;
                }).catch(()=>{

                })
            },

            //房间详情（回显）
            getRoomDetail(){
                //双重保障房间id
                if (!this.currentRoomId) {
                    this.currentRoomId = this.$route.query.roomId;
                    if (!this.currentRoomId) {
                        return;
                    }
                }
                roomDetail(this.currentRoomId).then(res => {
                    console.log('房间详情响应:', res);
                    const detail = res.data;
                    // 1.填充表单数据
                    this.roomDetailForm = { ...detail };
                    this.imageFileList = (detail.roomImage || []).map((url, index) => ({
                        name: `图片${index+1}.png`,   // 可随意命名
                        url: this.fixImageUrl(url)
                    }));
                    
                }).catch(error => {
                    console.error('获取详情失败:', error);
                });
            },

            // 修正图片 URL（将 127.0.0.1 替换为实际后端地址）
            fixImageUrl(url) {
                if (!url) return '';
                // 替换错误的本地地址
                if (url.includes('127.0.0.1:11345')) {
                return url.replace('http://127.0.0.1:11345', 'http://mashang.eicp.vip:5555/ms_stu_pro345');
                }
                // 如果返回的是相对路径（如 /profile/upload/xxx），拼接基础路径
                if (url.startsWith('/profile')) {
                return `http://mashang.eicp.vip:5555/ms_stu_pro345${url}`;
                }
                return url;
            },    

            //提交编辑后的数据
            submitData(formName){
                //表单验证
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        //新增房间
                        if(this.formStatus == 'add'){
                            
                            const addData = this.roomDetailForm;
                            addRoom(addData).then(res=>{
                                if(res.status == 200){
                                    this.$message.success(res.message);
                                    setTimeout(() => this.$router.push({
                                        path: "/parkmanage/roomManage"
                                    }), 1500);
                                }else{
                                    this.$message.error(res.message);
                                }  
                            }).catch(()=>{

                            })
                        }//修改房间
                        else if(this.formStatus == 'edit'){
                            const editData = this.roomDetailForm;
                            editData.roomId = this.currentRoomId;
                            editRoom(editData).then(res=>{
                                if(res.status == 200){
                                    this.$message.success(res.message);
                                    setTimeout(() => this.$router.push({
                                        path: "/parkmanage/roomManage"
                                    }), 1500);
                                }else{
                                    this.$message.error(res.message);
                                }  
                            }).catch(()=>{

                            })
                        }
                    } else {
                        return false;
                    }
                });
        
                
            },

            //跳转至管理界面
            closePage(){
                this.$router.push({
                    path: "/parkmanage/roomManage"
                })
            },

            //表单验证
            onSubmit() {
                console.log('submit!');
            },

            // 上传前校验
            beforeUpload(file) {
                const isImage = file.type === 'image/jpeg' || file.type === 'image/png';
                const isLt500k = file.size / 1024 < 500;
                if (!isImage) this.$message.error('只能上传 JPG/PNG 格式');
                if (!isLt500k) this.$message.error('图片大小不能超过 500KB');
                return isImage && isLt500k;
            },
           
           handleSuccess(response, file, fileList) {
                if (response.code === 200) {
                    let imageUrl = response.data || response.url;
                    if (!imageUrl) {
                        this.$message.error('上传响应缺少图片地址');
                        return;
                    }
                    // 修正 URL
                    imageUrl = this.fixImageUrl(imageUrl);
                    // 将完整 URL 挂载到 file 对象上（关键）
                    file.url = imageUrl;
                    // 更新提交数组
                    this.roomDetailForm.roomImage.push(imageUrl);
                    // 更新显示列表（确保每个文件都有 url）
                    this.imageFileList = fileList.map(f => {
                        if (!f.url && f.response) {
                            f.url = this.fixImageUrl(f.response.data || f.response.url);
                        }
                        return f;
                    });
                    this.$message.success('上传成功');
                } else if (response.code === 401) {
                    this.$message.error('认证失败，请重新登录');
                } else {
                    this.$message.error(response.msg || '上传失败');
                }
            },
            
            handleError(err, file) {
                this.$message.error(`${file.name} 上传失败`);
            },

            handleRemove(file, fileList) {
                // 情况1：组件内部触发的 on-remove（传了两个参数）
                if (fileList) {
                    this.imageFileList = fileList;
                    this.roomDetailForm.roomImage = fileList.map(f => f.url).filter(url => url);
                    return;
                }
                // 情况2：自定义删除按钮触发的（只传了 file）
                // 获取当前文件列表（从 upload 组件或本地 imageFileList）
                const currentList = this.$refs.upload ? this.$refs.upload.fileList : this.imageFileList;
                // 过滤掉要删除的文件（用 uid 唯一标识）
                const newFileList = currentList.filter(f => f.uid !== file.uid);
                // 更新显示列表
                this.imageFileList = newFileList;
                // 更新提交用的数组
                this.roomDetailForm.roomImage = newFileList.map(f => f.url).filter(url => url);
            },
         
            handlePictureCardPreview(file) {
                // Element UI 的 file 对象中，图片URL通常存储在 file.url
                // 如果 file.url 不存在，尝试从 file.response 中获取
                const url = file.url || (file.response && file.response.data);
                if (url) {
                this.dialogImageUrl = url;
                this.dialogVisible = true;
                } else {
                console.warn('无法获取图片URL', file);
                this.$message.error('预览失败：未找到图片地址');
                }
            },
        },
        watch:{
            'roomDetailForm.buildingId':{
                handler(newVal, oldVal){
                    if(this.formStatus =='add') {
                        this.roomDetailForm.floorId = null;
                        this.getFloorNameList(newVal);
                    }else if (this.formStatus =='edit'){
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