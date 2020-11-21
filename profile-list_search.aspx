<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="profile-list_search.aspx.cs" Inherits="Default3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <meta charset='utf-8'/>
		
		<style>

			textarea {
				border:2px solid #ccc;
				padding: 10px;
				vertical-align: top;
				width: 25%;
			}

			.animated {
				-webkit-transition: height 0.2s;
				-moz-transition: height 0.2s;
				transition: height 0.2s;
			}

		</style>
		<script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js'></script>
		<script src='jquery.autosize.js'></script>
		<script>
		    $(function () {
		        //$('.normal').autosize();
		        //$('.animated').autosize();
		        $('textarea').autosize();
		    });
		</script>
        <script src="js/jquery.js"></script>
    <script src="js/ajaxupload-min.js"></script>
<%--    <link href="css/baseTheme/style.css" rel="stylesheet" media="all" />--%>
    <link rel="stylesheet" type="text/css" href="css/master.css"/>
    <link href="css/classicTheme/style.css" rel="stylesheet" media="all" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_top_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_left_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <div class="clearfix" id="group_header"><!-- group -->

            <%--<div>
 <asp:UpdatePanel ID="UpdatePanel3" runat="server"
 UpdateMode="Always">
 <ContentTemplate>--%>


         <ajaxToolkit:ModalPopupExtender ID="MPECircleMore" runat="server" PopupControlID="pnCircleMore" TargetControlID="btnFAKE2"                                      
             DropShadow="true"  CancelControlID="btnCircleMoreCancel" Drag="false" RepositionMode="None" X="870" Y="70">
        </ajaxToolkit:ModalPopupExtender>
           <asp:Panel ID="pnCircleMore" runat="server" CssClass="popup" Style="display:none;" >
               <asp:ListView ID="lstCircleMore" runat="server" DataSourceID="circlemoreDS" OnItemCommand="lstCircleMore_ItemCommand">
                   
                   <EditItemTemplate>
                       <span style="">ID:
                       <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
                       <br />
                       Name:
                       <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                       <br />
                       UserId:
                       <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                       <br />
                       <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                       <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                       <br />
                       <br />
                       </span>
                   </EditItemTemplate>
                   <EmptyDataTemplate>
                       <span>No more circles found.</span>
                   </EmptyDataTemplate>
                   <InsertItemTemplate>
                       <span style="">ID:
                       <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
                       <br />
                       Name:
                       <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                       <br />
                       UserId:
                       <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                       <br />
                       <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                       <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                       <br />
                       <br />
                       </span>
                   </InsertItemTemplate>
                   <ItemTemplate>
                       <span style="">
                       
                       <asp:Button ID="ButtonLabel" runat="server" Text='<%# Eval("Name") %>' CommandName="morecircle" />
                       
                       <br />
                       </span>
                   </ItemTemplate>
                   <LayoutTemplate>
                       <div id="itemPlaceholderContainer" runat="server" style="">
                           <span runat="server" id="itemPlaceholder" />
                       </div>
                       <div style="">
                       </div>
                   </LayoutTemplate>
                   <SelectedItemTemplate>
                       <span style="">ID:
                       <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                       <br />
                       Name:
                       <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                       <br />
                       UserId:
                       <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                       <br />
                       <br />
                       </span>
                   </SelectedItemTemplate>
               </asp:ListView>
               <asp:SqlDataSource ID="circlemoreDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="circlemoreDS_Selecting" SelectCommand="SELECT * FROM [UserCircles] WHERE ([UserId] = @UserId)">
                   <SelectParameters>
                       <asp:Parameter Name="UserId" Type="Object" />
                   </SelectParameters>
               </asp:SqlDataSource>
               <asp:Button ID="btnCircleMoreCancel" runat="server" Text="Close" />
           </asp:Panel>
         
           
      <div class="clearfix grpelem" id="group_column"><!-- column -->
       <ul class="MenuBar shadow rounded-corners clearfix colelem" id="group_menu_bar"><!-- horizontal box -->
       <asp:Button ID="btnFAKE2" runat="server" Text="Fake Button" style="display: none;" />
          <ajaxToolkit:ModalPopupExtender ID="MPEAddCircle" runat="server" PopupControlID="pnAddCircle" TargetControlID="btnFAKE2"                                      
             DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnCircleCancel" Drag="false">
        </ajaxToolkit:ModalPopupExtender>
           <asp:Panel ID="pnAddCircle" runat="server" CssClass="popup" Style="display:none;">
               Enter Circle Name : <asp:TextBox ID="txtNewCircle" runat="server"></asp:TextBox>
               <asp:Button ID="btnCircleCreate" runat="server" Text="Create" OnClick="btnCircleCreate_Click" />
               <asp:Button ID="btnCircleCancel" runat="server" Text="Cancel" />
               </asp:Panel>


        <asp:Menu ID="MenuSub" runat="server" Orientation="Horizontal" BorderStyle="Double" CssClass="Menu" OnMenuItemClick="MenuSub_MenuItemClick">
            <Items>
                <asp:MenuItem Text="All" Value="All"></asp:MenuItem>
                <asp:MenuItem Text="Close Friends" Value="Close Friends"></asp:MenuItem>
                <asp:MenuItem Text="Family" Value="Family"></asp:MenuItem>
                <asp:MenuItem Text="Acquaintances" Value="Acquaintances"></asp:MenuItem>
                <asp:MenuItem Text="More..." Value="More..."></asp:MenuItem>
                <asp:MenuItem Text="+" Value="+"></asp:MenuItem>
            </Items>
        </asp:Menu>
        
          <%-- <ajaxToolkit:DropDownExtender runat="server" ID="DDE"
    TargetControlID="MenuSub" 
    DropDownControlID="DropPanel" />--%>
           
        
        
       </ul>
        <%--  </ContentTemplate>

 </asp:UpdatePanel>
     </div>--%>
       <ul class="MenuBar clearfix colelem" id="<%--menuu3731--%>main_menu"><!-- horizontal box -->
        <li class="MenuItemContainer clearfix grpelem" id="<%--u3787--%>main_menu_vertical"><!-- vertical box -->
         <asp:DropDownList ID="DropDownList1" Visible="false" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" BackColor="#525461" ForeColor="White">
            <asp:ListItem>All</asp:ListItem>
            <asp:ListItem>People</asp:ListItem>
            <asp:ListItem>Page</asp:ListItem>
            <asp:ListItem>Group</asp:ListItem>
        </asp:DropDownList>
         <div class="SubMenu  MenuLevel1 clearfix" id="<%--u3792--%>menu_sub_level1"><!-- vertical box -->
          <ul class="SubMenuView clearfix colelem" id="<%--u3793--%>menu_sub_view"><!-- vertical box -->
           
          </ul>
         </div>
        </li>
       </ul>
      </div>
      
     </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="clearfix colelem" id="divider_full"><!-- group -->
     <div class="clearfix grpelem" id="divider_profile_cover"><!-- column -->
   <%--   <div class="clearfix colelem" id="u523"><!-- group -->
       <div class="clearfix grpelem" id="u524"><!-- group -->--%>

        <div class=" clearfix grpelem" id="profile_item"><!-- group -->
        <asp:DetailsView ID="UserProfile" runat="server" AutoGenerateRows="False" DataKeyNames="UserId" DataSourceID="UserProfileDataSource"  Width="175px" Font-Bold="True" ForeColor="White" BorderWidth="0px">
           <EditRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
           <Fields>
               <asp:TemplateField>
                   <ItemTemplate>
                       
                     <%--  <asp:Button ID="btnChangeProfilePic" runat="server" Text="Change" CssClass="btnChangeStyle" /> 
                       <asp:ImageButton ID="ImageProfile" runat="server" Width="165px" Height="160px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' OnClick="ImageProfile_Click" />
                        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderProfilePic" runat="server" PopupControlID="PanelProfile" TargetControlID="btnChangeProfilePic"                                      
             DropShadow="true" BackgroundCssClass="modalBackground"
             OnOkScript="onOk()" Drag="false">
        </ajaxToolkit:ModalPopupExtender>  --%>  
                       <div class="image">
    
<%--                <asp:ImageButton ID="imgchange" CssClass="hoverimage" Width="30" runat="server" Text="Change" ImageUrl="~/images/icon/white/photo146.png"  /> --%>
        
                       <asp:Image ID="ImageProfile" runat="server"  ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' CssClass="whiteborder" />
                        
   
                      <%--  <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderProfilePic" runat="server" PopupControlID="PanelProfile" TargetControlID="imgchange"                                      
             DropShadow="true" BackgroundCssClass="modalBackground"
             OnOkScript="onOk()" Drag="false">
        </ajaxToolkit:ModalPopupExtender>    --%>
         </div>                 
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:BoundField DataField="FullName"  SortExpression="FullName"   />
               <asp:BoundField DataField="Gender"  SortExpression="Gender" />
               <asp:BoundField DataField="Age"  SortExpression="Age"  />
               <asp:BoundField DataField="Career"  SortExpression="Career" />
               <asp:BoundField DataField="CareerDescription" SortExpression="CareerDescription" />
           </Fields>
          
           </asp:DetailsView>
            <asp:Panel ID="PanelProfile" runat="server" CssClass="popup" Style="display:none;">
         
                Choose Your Profile Picture:<br />
              
          <asp:FileUpload ID="FileUploadProfile" runat="server" />
        <asp:Button ID="btnChangeProfile" runat="server" Text="Change" OnClick="btnChangeProfile_Click"  />
        <asp:Button ID="Button3" runat="server" Text="Cancel" />
                           
            
        </asp:Panel>
            </div>
      
            <asp:SqlDataSource ID="UserProfileDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="UserProfileDataSource_Selecting" SelectCommand="SELECT * FROM [UserProfiles] WHERE ([UserId] = @UserId)" UpdateCommand="UPDATE [UserProfiles] SET [FullName] = @FullName, [Gender] = @Gender, [Age] = @Age, [Career] = @Career, [CareerDescription] = @CareerDescription, [ProfilePicture] = @ProfilePicture, [CoverPicture] = @CoverPicture WHERE [UserId] = @original_UserId AND (([FullName] = @original_FullName) OR ([FullName] IS NULL AND @original_FullName IS NULL)) AND (([Gender] = @original_Gender) OR ([Gender] IS NULL AND @original_Gender IS NULL)) AND (([Age] = @original_Age) OR ([Age] IS NULL AND @original_Age IS NULL)) AND (([Career] = @original_Career) OR ([Career] IS NULL AND @original_Career IS NULL)) AND (([CareerDescription] = @original_CareerDescription) OR ([CareerDescription] IS NULL AND @original_CareerDescription IS NULL)) AND (([ProfilePicture] = @original_ProfilePicture) OR ([ProfilePicture] IS NULL AND @original_ProfilePicture IS NULL)) AND (([CoverPicture] = @original_CoverPicture) OR ([CoverPicture] IS NULL AND @original_CoverPicture IS NULL))" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [UserProfiles] WHERE [UserId] = @original_UserId AND (([FullName] = @original_FullName) OR ([FullName] IS NULL AND @original_FullName IS NULL)) AND (([Gender] = @original_Gender) OR ([Gender] IS NULL AND @original_Gender IS NULL)) AND (([Age] = @original_Age) OR ([Age] IS NULL AND @original_Age IS NULL)) AND (([Career] = @original_Career) OR ([Career] IS NULL AND @original_Career IS NULL)) AND (([CareerDescription] = @original_CareerDescription) OR ([CareerDescription] IS NULL AND @original_CareerDescription IS NULL)) AND (([ProfilePicture] = @original_ProfilePicture) OR ([ProfilePicture] IS NULL AND @original_ProfilePicture IS NULL)) AND (([CoverPicture] = @original_CoverPicture) OR ([CoverPicture] IS NULL AND @original_CoverPicture IS NULL))" InsertCommand="INSERT INTO [UserProfiles] ([UserId], [FullName], [Gender], [Age], [Career], [CareerDescription], [ProfilePicture], [CoverPicture]) VALUES (@UserId, @FullName, @Gender, @Age, @Career, @CareerDescription, @ProfilePicture, @CoverPicture)" OldValuesParameterFormatString="original_{0}">
               <DeleteParameters>
                   <asp:Parameter Name="original_UserId" Type="Object" />
                   <asp:Parameter Name="original_FullName" Type="String" />
                   <asp:Parameter Name="original_Gender" Type="String" />
                   <asp:Parameter Name="original_Age" Type="Int32" />
                   <asp:Parameter Name="original_Career" Type="String" />
                   <asp:Parameter Name="original_CareerDescription" Type="String" />
                   <asp:Parameter Name="original_ProfilePicture" Type="Object" />
                   <asp:Parameter Name="original_CoverPicture" Type="Object" />
               </DeleteParameters>
               <InsertParameters>
                   <asp:Parameter Name="UserId" Type="Object" />
                   <asp:Parameter Name="FullName" Type="String" />
                   <asp:Parameter Name="Gender" Type="String" />
                   <asp:Parameter Name="Age" Type="Int32" />
                   <asp:Parameter Name="Career" Type="String" />
                   <asp:Parameter Name="CareerDescription" Type="String" />
                   <asp:Parameter Name="ProfilePicture" Type="Object" />
                   <asp:Parameter Name="CoverPicture" Type="Object" />
               </InsertParameters>
               <SelectParameters>
                   <asp:Parameter Name="UserId" Type="Object" />
               </SelectParameters>
               <UpdateParameters>
                   <asp:Parameter Name="FullName" Type="String" />
                   <asp:Parameter Name="Gender" Type="String" />
                   <asp:Parameter Name="Age" Type="Int32" />
                   <asp:Parameter Name="Career" Type="String" />
                   <asp:Parameter Name="CareerDescription" Type="String" />
                   <asp:Parameter Name="ProfilePicture" Type="Object" />
                   <asp:Parameter Name="CoverPicture" Type="Object" />
                   <asp:Parameter Name="original_UserId" Type="Object" />
                   <asp:Parameter Name="original_FullName" Type="String" />
                   <asp:Parameter Name="original_Gender" Type="String" />
                   <asp:Parameter Name="original_Age" Type="Int32" />
                   <asp:Parameter Name="original_Career" Type="String" />
                   <asp:Parameter Name="original_CareerDescription" Type="String" />
                   <asp:Parameter Name="original_ProfilePicture" Type="Object" />
                   <asp:Parameter Name="original_CoverPicture" Type="Object" />
               </UpdateParameters>
           </asp:SqlDataSource>
            
           <div class="shadow museBGSize grpelem" id="cover_item">
          <asp:DetailsView ID="UserCover" runat="server" AutoGenerateRows="False" DataKeyNames="UserId" DataSourceID="UserProfileDataSource" Width="400px" BorderWidth="0px">
           
           <Fields>
               <asp:TemplateField>
                   <ItemTemplate>
                       <%--<asp:Button ID="btnChangeCoverPic" runat="server" Text="Change" CssClass="btnChangeStyle" /> 
                       <asp:Image ID="ImageCover" runat="server" width="400px" height="240px" ImageUrl='<%# "CoverHandler.ashx?userid=" + Eval("UserId") %>'/>
                     <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderCoverPic" runat="server" PopupControlID="pnChangeCover" TargetControlID="btnChangeCoverPic" DropShadow="true" BackgroundCssClass="modalBackground" Drag="false" />--%>
                       <div class="image2" style="left: -4px;">
<%--                       <asp:ImageButton ID="btnChangeCoverPic" runat="server" Text="Change" CssClass="hoverimage2" Width="30px" ImageUrl="~/images/icon/white/photo146.png" /> --%>
                       <asp:Image ID="ImageCover" runat="server" CssClass="covermagrin" width="416px" height="236px" ImageUrl='<%# "CoverHandler.ashx?userid=" + Eval("UserId") %>'/>
                    </div>
<%--                            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderCoverPic" runat="server" PopupControlID="pnChangeCover" TargetControlID="btnChangeCoverPic" DropShadow="true" BackgroundCssClass="modalBackground" Drag="false" />--%>

                        
                   </ItemTemplate>
               </asp:TemplateField>
               
           </Fields>
           
           </asp:DetailsView>
               <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                   <Triggers>
                       <asp:AsyncPostBackTrigger ControlID="SendFriendReq" EventName="Click" />
                       <asp:AsyncPostBackTrigger ControlID="btnReq" EventName="Click" />
                   </Triggers>
                   <ContentTemplate>
                       <asp:Button ID="SendFriendReq" runat="server" Text="Add Friend" OnPreRender="SendFriendReq_PreRender" OnClick="SendFriendReq_Click" style=" background-color: #26284f;color: white;" />
               <ajaxToolkit:HoverMenuExtender ID="PopEx" runat="server"
    TargetControlID="SendFriendReq"
    PopupControlID="pnlBtnReq"
    PopupPosition="Bottom" />
               <asp:Panel ID="pnlBtnReq" runat="server" OnPreRender="pnlBtnReq_PreRender" Style="display:none;">
                   <asp:Button ID="btnReq" runat="server" Text="Unfriend" OnClick="btnReq_Click" style=" background-color: #26284f;color: white;" />
               </asp:Panel>
                   </ContentTemplate>
               </asp:UpdatePanel>
                              

                <asp:Panel ID="pnChangeCover" runat="server" CssClass="popup" Style="display:none;">
         
                Choose Your Cover Picture:<br />
              
          <asp:FileUpload ID="FileUpload2" runat="server" />
        <asp:Button ID="btnChangeCover" runat="server" Text="Change" OnClick="btnChangeCover_Click"  />
        <asp:Button ID="Button2" runat="server" Text="Cancel" />
                           
            
        </asp:Panel>
             
                   </div>
        
         <%--  </div>
            </div>--%>
         <div class="post_new_profile_full">
                <div style="margin-bottom: 10px;margin-left: 500px;">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/icon/black/tag.png" Width="20" Height="20" style="display: none;" />
                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/icon/black/location.png" Width="20" style="display: none;" />

                 
<%--                    <asp:FileUpload ID="FileUpload1" runat="server" Width="100px" Style="display: none" />--%>

                    <%--                 <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/icon/black/attach.png" Width="20" OnClientClick=" clk();" />--%>
                    <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/images/icon/black/emoticon.png" Width="20" Visible="false" />
                </div>
                <%-- <asp:TextBox ID="txt" runat="server" TextMode="MultiLine" Width="573px"></asp:TextBox>--%>
       <%--     <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Always">
                 <Triggers>
                
                   
                    
                 </Triggers>
                 <ContentTemplate>--%>
                   <ajaxToolkit:TabContainer ID="TabContainerPost" runat="server" CssClass="postboxall"  ActiveTabIndex="0" width="132"

             >
                       <ajaxToolkit:TabPanel HeaderText="Text" runat="server">
                           <ContentTemplate>
                                               <asp:TextBox ID="txtNewPost" class='animated' style="width:568px;max-height: 300px; margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />

                                <ajaxToolkit:AutoCompleteExtender CompletionListCssClass="AutoExtender" OnClientPopulated="GetFriendImage" OnClientItemSelected="SetTag" ID="AutoCompleteExtender4" runat="server" MinimumPrefixLength="2" ServiceMethod="GetFriendTag" ServicePath="WebService.asmx" TargetControlID="txtNewPost" > </ajaxToolkit:AutoCompleteExtender> 

                                </ContentTemplate>
                       </ajaxToolkit:TabPanel>
                        <ajaxToolkit:TabPanel HeaderText="Photo" runat="server">
                           <ContentTemplate>
                                               <asp:TextBox ID="txtPhotoPost" class='animated' style="width:568px;max-height: 300px;margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />
          <%--     <ajaxToolkit:AsyncFileUpload ThrobberID="imgLoader" CssClass="FileUploadClass" ID="AsyncFileUpload1" runat="server" OnUploadedComplete="AsyncFileUpload1_UploadedComplete" />
<asp:Image ID="imgLoader"  CssClass="imgLoader" runat="server"
        ImageUrl = "~/images/loading2.gif" />--%>
                <div class="demo" runat="server" > </div>
               <asp:HiddenField ID="uploaded_files" runat="server" />
                 <script>
                     $('.demo').ajaxupload({
                         url: 'upload.aspx',
                         autoStart: true,
                         maxFileSize: '2G',
                         finish: function (d) {
                             alert(d);
                             <%--  $("#<%=uploaded_files.ClientID %>").val(d);--%>

                         }
                     });


                     //var file_list = AU.files;//get all the files object

                     //var file = file_list[0]; //a single fileObject
                     ////alert(file);
    </script>

                                </ContentTemplate>
                       </ajaxToolkit:TabPanel>
                        <ajaxToolkit:TabPanel HeaderText="Video" runat="server">
                           <ContentTemplate>
                                               <asp:TextBox ID="txtVideoPost" class='animated' style="width:568px;max-height: 300px; margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />
               <ajaxToolkit:AsyncFileUpload ThrobberID="imgLoader2" CssClass="FileUploadClass" ID="AsyncFileUpload2" runat="server" OnUploadedComplete="AsyncFileUpload2_UploadedComplete" />
                               <asp:Image ID="imgLoader2" CssClass="imgLoader" runat="server"
        ImageUrl = "~/images/loading2.gif" />

 <%--<div class="demo" runat="server" > </div>
               <asp:HiddenField ID="uploaded_files" runat="server" />
                 <script>
                     $('.demo').ajaxupload({
                         url: 'upload.aspx',
                         autoStart: true,
                         finish: function (d) {
                             //alert(d);
                             $("#<%=uploaded_files.ClientID %>").val(d);

                         }
                     });


                         //var file_list = AU.files;//get all the files object

                         //var file = file_list[0]; //a single fileObject
                         ////alert(file);
    </script>--%>

                                </ContentTemplate>
                       </ajaxToolkit:TabPanel>
                   </ajaxToolkit:TabContainer>
                       
             

<%--         <ajaxToolkit:AutoCompleteExtender CompletionListCssClass="AutoExtender" OnClientPopulated="GetFriendImage" OnClientItemSelected="GetFriendProfile" BehaviorID="acExt" ID="AutoCompleteExtenderPostTag" UseContextKey="true" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" runat="server" MinimumPrefixLength="1" ServiceMethod="GetFriendTag" ServicePath="WebService.asmx" TargetControlID="txtNewPost" > </ajaxToolkit:AutoCompleteExtender> --%>

         <%--    <asp:TextBox id="demo" class="tags-input" style="
    border: 1px solid #c4c4c4;
" runat="server"/>--%>
           
                <div style="margin-top: 10px">
                    <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/images/icon/black/privacy.png" Width="20" Height="20" />
                    <asp:DropDownList ID="ddlPrivacy" runat="server">
                        <asp:ListItem>Public</asp:ListItem>
                        <asp:ListItem>Friends</asp:ListItem>
                        <asp:ListItem>Only Me</asp:ListItem>
                    </asp:DropDownList>
               
              <%--      <asp:Image ID="Image1" Width="50" Height="50" runat="server" />--%>
                     
                </div>
                  
                <div style="float: right; margin-top: -20px; margin-bottom: 10px">

                    <asp:ImageButton ID="btnNewPost" CssClass="icon" runat="server" ImageUrl="~/images/icon/black/post.png" Width="20" OnClick="btnNewPost_Click" />
                 
                   
                 <%--      </ContentTemplate>
</asp:UpdatePanel>--%>
              <%--  <ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender2"
                        TargetControlID="UpdatePanel4" runat="server">
                        <Animations>
                <OnUpdating>
                    <Parallel>
                        <ScriptAction Script='onUpdatingpost();' />
                   
                    </Parallel>
                </OnUpdating>
                <OnUpdated>
                    <Parallel>
                        <ScriptAction Script='onUpdatedpost();' />
                    
    
                    </Parallel>
                </OnUpdated>
                        </Animations>
                    </ajaxToolkit:UpdatePanelAnimationExtender>--%>
                <div id="divImagepost" style="display: none;">
                        <div class="spinner" style="margin-left: -50px;margin-top: -49px;">
                            <div class="bounce1"></div>
                            <div class="bounce2"></div>
                            <div class="bounce3"></div>
                        </div>
                    </div>

                    <%-- <asp:Button ID="" runat="server" Text="Post" Width="50px" EnableViewState="False"  />--%>
                </div>
         <asp:Button ID="btnFAKE" runat="server" Text="Fake Button" style="display: none;" />
          <ajaxToolkit:ModalPopupExtender ID="MPEShare" runat="server" PopupControlID="PanelShare" TargetControlID="btnFAKE"                                      
             DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnCancel"
              Drag="false">
        </ajaxToolkit:ModalPopupExtender>
           <asp:Panel ID="PanelShare" runat="server" CssClass="popup" Style="display:none;">
         
               Share: <asp:DropDownList ID="ddlShareTo" runat="server">
                   <asp:ListItem>On my timeline</asp:ListItem>
                   <asp:ListItem>On a friends timeline</asp:ListItem>
                   <asp:ListItem>In a group</asp:ListItem>
                      </asp:DropDownList><br />
               
               <asp:TextBox ID="txtFriendsName" runat="server" Visible="true"></asp:TextBox><br />
               <asp:TextBox ID="txtFriendsID" runat="server" CssClass="displaynone"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender OnClientItemSelected="GetFriendID" ID="AutoCompleteExtender1" runat="server" MinimumPrefixLength="1" ServiceMethod="GetFriendInfo" ServicePath="WebService2.asmx" TargetControlID="txtFriendsName"> </ajaxToolkit:AutoCompleteExtender> 
               <asp:TextBox ID="txtShareText" OnClick="this.value=''" runat="server" Text="" TextMode="MultiLine" Rows="2" Width="300" style="overflow:hidden" onkeyup="setHeight(this)" ToolTip="Say Something about this..."></asp:TextBox><br />
             
        <asp:Button ID="btnShare" runat="server" Text="Share" OnClick="btnShare_Click"  />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                           
            
        </asp:Panel>
      <div class="clearfix colelem" id="divider_post"><!-- group -->
       <div class="clearfix grpelem" id="u599"><!-- full post section -->
       <%--<div class="clearfix grpelem" id="u600"><!-- group -->--%>
        <div class="clearfix grpelem" id="pu603"><!-- post divider -->
       
           

        
            
                      <div>
 <asp:UpdatePanel ID="UpdatePanel1" runat="server"
 UpdateMode="Conditional">
 <ContentTemplate>
     <asp:ListView ID="ListView1" runat="server" DataKeyNames="PostId,LikeId,UserId" DataSourceID="PostsDataSource1" OnItemDataBound="ListView1_ItemDataBound" OnItemCommand="ListView1_ItemCommand" EnableViewState="False">
         
         <EditItemTemplate>
             <span style="">
             <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' Visible="false" />
             <br />
            
             </span>
             <asp:Label ID="Label1" runat="server" Text='<%# Eval("PostId") %>' Visible="false" />
                              <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                             <asp:Label ID="PostContentTypeLabel" runat="server" Text='<%# Eval("PostContentType") %>' 

Visible="false" />
              
                            <%--   <div id="post_backcolor2" runat="server" class="colelem post_section_full"><!-- post 

section -->--%>
                                   <asp:Panel id="post_backcolor" runat="server" class="colelem post_section_full_list">
                                      
                   <%-- <div style="float:right;margin-right:10px;">
                           <asp:ImageButton ID="EditButton" ImageUrl="~/images/icon/gray/edit.png" Width="20" 

runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" ImageUrl="~/images/icon/gray/delete.png" Width="20" 

runat="server" CommandName="Deletepost" Text="Delete" />
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?

userid=" + Eval("UserId") %>' />

                       </div>--%>
                       
           <%--<div class="position_content">--%>
            <div class=" colelem post_profile_photo">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />

                          

            </div>

               <div class="post_top_info">
               <div style="float:right;">
                                        <asp:ImageButton ID="EditButton" ImageUrl="~/images/icon/gray/edit.png" Width="20" 

runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" ImageUrl="~/images/icon/gray/delete.png" Width="20" 

runat="server" CommandName="Deletepost" Text="Delete" />
                                           </div>
                   <asp:Label ID="PostUserLabel" runat="server" Text='<%# Eval("PostUser") %>' />
                   <br />
              
                   <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("PostDate") %>' />
                   <br />
                         </div>
                   
            
                <div class="post_media_section">
                    <div class="displayed">
                <embed id='embed1' autostart='false' runat="server" name='mediaPlayer' type='application/x-mplayer2' 

pluginspage='http://microsoft.com/windows/mediaplayer/en/download/'  displaysize='4' autosize='-1' bgcolor='darkblue' 

showcontrols='true' showtracker='-1' showdisplay='0' showstatusbar='-1' videoborder3d='-1' width='200' height='200'  

designtimesp='5311' loop='false' src='<%# "Handler.ashx?postid=" + Eval("PostId") %>' visible="false"/>
                </div>
                    </div>
               <div class="colelem post_section">
                   <asp:TextBox ID="PostTextBox" BorderWidth="1" BorderStyle="Solid" BorderColor="Black" runat="server" 

Text='<%# Bind("Post") %>' onkeyup="setHeight(this)" Width="573" TextMode="MultiLine" />
                   <br /><br />
                   <div style="margin-left:10px;">
               <asp:Button ID="UpdateButton" runat="server" 

CommandName="Updatepost" Text="Update" />
                   <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel"/>
                   

</div>
               </div>
               
           <%--</div>--%>
                      <div class="colelem like_dislike_share_section_list" style="background-color:#DEF0F4">
                       <asp:ImageButton ID="LinkButtonLike" runat="server" CommandName="LikeButton" Width="20" 

ImageUrl="~/images/icon/gray/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server">Comment</asp:LinkButton>--%>
                  

        <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                       <asp:ImageButton ID="ImageButtonShare" 

runat="server" CommandName="SharePostId" Width="20" ImageUrl="~/images/icon/black/share3.png" ></asp:ImageButton>

                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            
                            <br />
                            <asp:LinkButton ID="LinkViewAllComment" runat="server" Visible="false">View all 

comments</asp:LinkButton>
                           </div>

          </asp:Panel>
             
         </EditItemTemplate>
         <EmptyDataTemplate>
             <span>No data was returned.</span>
         </EmptyDataTemplate>
         <InsertItemTemplate>
             <span style="">PostId:
             <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PostId") %>' />
             <br />
             Post:
             <asp:TextBox ID="PostTextBox" runat="server" Text='<%# Bind("Post") %>' />
             <br />
             PostDate:
             <asp:TextBox ID="PostDateTextBox" runat="server" Text='<%# Bind("PostDate") %>' />
             <br />
             UserId:
             <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
             <br />
             PostContent:
             <asp:TextBox ID="PostContentTextBox" runat="server" Text='<%# Bind("PostContent") %>' />
             <br />
             PostContentType:
             <asp:TextBox ID="PostContentTypeTextBox" runat="server" Text='<%# Bind("PostContentType") %>' />
             <br />
             PostUser:
             <asp:TextBox ID="PostUserTextBox" runat="server" Text='<%# Bind("PostUser") %>' />
             <br />
             LikeId:
             <asp:TextBox ID="LikeIdTextBox" runat="server" Text='<%# Bind("LikeId") %>' />
             <br />
             DislikeId:
             <asp:TextBox ID="DislikeIdTextBox" runat="server" Text='<%# Bind("DislikeId") %>' />
             <br />
             <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
             <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
             <br />
             <br />
             </span>
         </InsertItemTemplate>
         <ItemTemplate>
           
              <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' Visible="false" />
                              <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                             <asp:Label ID="PostContentTypeLabel" runat="server" Text='<%# Eval("PostContentType") %>' Visible="false" />
              
                            <%--   <div id="post_backcolor2" runat="server" class="colelem post_section_full"><!-- post section -->--%>
                                   <asp:Panel id="post_backcolor" runat="server" class="colelem post_section_full_list">
                                      
                   <%-- <div style="float:right;margin-right:10px;">
                           <asp:ImageButton ID="EditButton" ImageUrl="~/images/icon/gray/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" ImageUrl="~/images/icon/gray/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />

                       </div>--%>
                       
           <%--<div class="position_content">--%>
            <div class=" colelem post_profile_photo">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />

                          

            </div>

               <div class="post_top_info">
               <div style="float:right;">
                                        <asp:ImageButton ID="EditButton" ImageUrl="~/images/icon/gray/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" ImageUrl="~/images/icon/gray/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                                           </div>
                   <asp:Label ID="PostUserLabel" runat="server" Text='<%# Eval("PostUser") %>' />
                   <br />
              
                   <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("PostDate") %>' />
                   <br />
                         </div>
                   
            
                <div class="post_media_section">
                    <div class="displayed">
                <embed id='embed1' autostart='false' runat="server" name='mediaPlayer' type='application/x-mplayer2' pluginspage='http://microsoft.com/windows/mediaplayer/en/download/'  displaysize='4' autosize='-1' bgcolor='darkblue' showcontrols='true' showtracker='-1' showdisplay='0' showstatusbar='-1' videoborder3d='-1' width='200' height='200'  designtimesp='5311' loop='false' src='<%# "Handler.ashx?postid=" + Eval("PostId") %>' visible="false"/>
                </div>
                    </div>
               <div class="colelem post_section_list">
                   <asp:Literal ID="PostLabel" runat="server" Text='<%# AddEmotes(Eval("Post").ToString()) %>' />
                   <br /></div>
               
           <%--</div>--%>
                      <div class="colelem like_dislike_share_section_list" style="background-color:#DEF0F4">
                       <asp:ImageButton ID="LinkButtonLike" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/gray/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server">Comment</asp:LinkButton>--%>
                          <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                       <asp:ImageButton ID="ImageButtonShare" runat="server" CommandName="SharePostId" Width="20" ImageUrl="~/images/icon/black/share3.png" ></asp:ImageButton>

                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            
                            <br />
                            <asp:LinkButton ID="LinkViewAllComment" runat="server" Visible="false">View all comments</asp:LinkButton>
                           </div>

          </asp:Panel>
                       <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                         <%--   </div>--%>

             <asp:ListView ID="ListView2" runat="server" DataKeyNames="PostId,LikeId,CommentUserId" DataSourceID="CommentsDataSource1" OnItemEditing="ListView2_ItemEditing" OnItemCreated="ListView2_ItemCreated" EnableViewState="false" InsertItemPosition="LastItem" OnItemInserting="ListView2_ItemInserting" OnItemDataBound="ListView2_ItemDataBound" OnItemCommand="ListView2_ItemCommand">
                
        <EditItemTemplate>
            <span>Comment:
            <asp:TextBox ID="CommentTextBox" runat="server" Text='<%# Bind("Comment") %>' />
            
            <br />
            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
            <br /><br /></span>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <span>No comment found.</span>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <asp:panel defaultbutton="InsertButton" runat="server">
            <span style="">
                        <%--<div class="_u608 f3s_top" id="_u608-f3s_top"></div>--%>
                     <div class="colelem comment_new_full_list">
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" OnClick="ImageProfile_Click" />
                    

                        </div>
                <div class="comment_new_section">
                <asp:TextBox ID="CommentTextBox" runat="server" onkeyup="setHeight(this)" Text='<%# Bind("Comment") %>' Width="500" />
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Comment" />
                </div>
              
                
               <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                </div>
                        <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                    </span>
                </asp:panel>
        </InsertItemTemplate>
        <ItemTemplate>
            <span style="">
                    <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                        <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' Visible="false" />

                  
                 <div class="colelem comment_post_full_list">
                   <%--  <div class="position_content" >--%>
           <div class=" grpelem comment_post_profile_photo">
                <asp:ImageButton ID="ImageProfile2" runat="server" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' OnClick="ImageProfile_Click" />

           </div>
                        
                <div class="comment_post_info">
                      <div style="float:right;">
                                        <asp:ImageButton ID="EditButton" ImageUrl="~/images/icon/gray/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" ImageUrl="~/images/icon/gray/delete.png" Width="20" runat="server" CommandName="Deletecomment" Text="Delete" />
                                           </div>
                <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' /><br />
                <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                     <div class="colelem comment_post_section_list">
                   <asp:Literal ID="PostLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                       <%--  </div>--%>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="colelem comment_post_like_section">
              <asp:ImageButton ID="LinkButtonLike" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/gray/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                            
          </div>
                        
                        <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                    </span>
        </ItemTemplate>
        <LayoutTemplate>
            <div id="itemPlaceholderContainer" runat="server" style="font-family: Verdana, Arial, Helvetica, sans-serif;">
                <span runat="server" id="itemPlaceholder" />
            </div>
            <div style="text-align: center;background-color: #5D7B9D;font-family: Verdana, Arial, Helvetica, sans-serif;color: #FFFFFF;">
            </div>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <span style="background-color: #E2DED6;font-weight: bold;color: #333333;">Comment:
            <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
            <br />
            CommentUser:
            <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' />
            <br />
            CommentDate:
            <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
            <br />
<br /></span>
        </SelectedItemTemplate>
        </asp:ListView>
         </ItemTemplate>
         <LayoutTemplate>
             <div id="itemPlaceholderContainer" runat="server" style="">
                 <span runat="server" id="itemPlaceholder" />
             </div>
             <div style="">
             </div>
         </LayoutTemplate>
         <SelectedItemTemplate>
             <span style="">PostId:
             <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' />
             <br />
             Post:
             <asp:Label ID="PostLabel" runat="server" Text='<%# Eval("Post") %>' />
             <br />
             PostDate:
             <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("PostDate") %>' />
             <br />
             UserId:
             <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
             <br />
             PostContent:
             <asp:Label ID="PostContentLabel" runat="server" Text='<%# Eval("PostContent") %>' />
             <br />
             PostContentType:
             <asp:Label ID="PostContentTypeLabel" runat="server" Text='<%# Eval("PostContentType") %>' />
             <br />
             PostUser:
             <asp:Label ID="PostUserLabel" runat="server" Text='<%# Eval("PostUser") %>' />
             <br />
             LikeId:
             <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' />
             <br />
             DislikeId:
             <asp:Label ID="DislikeIdLabel" runat="server" Text='<%# Eval("DislikeId") %>' />
             <br />
             <br />
             </span>
             <td>
<asp:Button ID="DeleteButton" runat="server" CommandName="Delete"
Text="Delete" />
<asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
</td>
             
         </SelectedItemTemplate>
     </asp:ListView>
   
        
        <asp:SqlDataSource ID="PostsDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [UserPosts] WHERE ([UserId] = @UserId) ORDER BY [PostDate] DESC" OnSelecting="PostsDataSource1_Selecting">
            <SelectParameters>
                <asp:Parameter Name="UserId" Type="Object" />
            </SelectParameters>
     </asp:SqlDataSource>
   
             <asp:SqlDataSource ID="CommentsDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [UserComments] WHERE ([PostId] = @PostId) ORDER BY [CommentDate]" OnSelecting="CommentsDataSource1_Selecting" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [UserComments] WHERE [CommentId] = @original_CommentId AND [Comment] = @original_Comment AND (([CommentUser] = @original_CommentUser) OR ([CommentUser] IS NULL AND @original_CommentUser IS NULL)) AND [CommentDate] = @original_CommentDate AND [PostId] = @original_PostId" InsertCommand="INSERT INTO [UserComments] ([CommentId], [Comment], [CommentUser], [CommentDate], [PostId]) VALUES (@CommentId, @Comment, @CommentUser, @CommentDate, @PostId)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [UserComments] SET [Comment] = @Comment WHERE [CommentId] = @original_CommentId AND [Comment] = @original_Comment AND (([CommentUser] = @original_CommentUser) OR ([CommentUser] IS NULL AND @original_CommentUser IS NULL)) AND [CommentDate] = @original_CommentDate AND [PostId] = @original_PostId">
            <DeleteParameters>
                <asp:Parameter Name="original_CommentId" />
                <asp:Parameter Name="original_Comment" Type="String" />
                <asp:Parameter Name="original_CommentUser" Type="String" />
                <asp:Parameter Name="original_CommentDate" Type="DateTime" />
                <asp:Parameter Name="original_PostId" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="CommentId" />
                <asp:Parameter Name="Comment" Type="String" />
                <asp:Parameter Name="CommentUser" Type="String" />
                <asp:Parameter Name="CommentDate" Type="DateTime" />
                <asp:Parameter Name="PostId" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter Name="PostId" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Comment" Type="String" />
                <asp:Parameter Name="CommentUser" Type="String" />
                <asp:Parameter Name="CommentDate" Type="DateTime" />
                <asp:Parameter Name="PostId" />
                <asp:Parameter Name="original_CommentId" />
                <asp:Parameter Name="original_Comment" Type="String" />
                <asp:Parameter Name="original_CommentUser" Type="String" />
                <asp:Parameter Name="original_CommentDate" Type="DateTime" />
                <asp:Parameter Name="original_PostId" />
            </UpdateParameters>
        </asp:SqlDataSource>
           <asp:SqlDataSource ID="LikeDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [UserLikes]"></asp:SqlDataSource>

        
        </div>
      </ContentTemplate>

 </asp:UpdatePanel>
     </div>
        
       
       
      </div>
     </div>
     <div class="" id="divider_right" style="
    margin-top: -370px;
    margin-left: 600px;
"><!-- column -->
         <div id="listgrid_bar" style="width: 150px;	position: relative;">
         <asp:ImageButton ID="ImageButtonGrid" runat="server" CssClass="" ImageUrl="~/images/icon/black/horizontal20.png" OnClick="ImageButtonGrid_Click" Height="40px" Width="40px"   />
             <asp:ImageButton ID="ImageButtonList" runat="server" CssClass="" ImageUrl="~/images/icon/black/six15.png" OnClick="ImageButtonList_Click" Height="40px" Width="40px"   />
            
              <div id="background_change" style="display:none;">
           <asp:Button ID="btnChangeBackground" runat="server" Text="Change Background"  /></div>
      <asp:Panel ID="pnChangeBackground" runat="server" CssClass="popup" Style="display:none;">
         
                Choose Your Background:<br />
              
          <ajaxToolkit:AjaxFileUpload ID="AjaxFileUpload1" runat="server" OnUploadComplete="AjaxFileUpload1_UploadComplete" 

OnClientUploadComplete="OnClientUploadComplete" MaximumNumberOfFiles="1" AllowedFileTypes="jpg,jpeg,tiff,png,gif"/>
          <asp:Button ID="btnbckcancel" runat="server" Text="Cancel" />
        </asp:Panel>
        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender2" runat="server" PopupControlID="pnChangeBackground" 

TargetControlID="btnChangeBackground"   CancelControlID="btnbckcancel"                                    
             DropShadow="true" BackgroundCssClass="modalBackground"
             OnOkScript="onOk()" Drag="false">
        </ajaxToolkit:ModalPopupExtender>
             
              </div>
      
      <div class=" side_menu"><!-- group -->
       <div class="clearfix grpelem" id="side_menu_bar" style="
    margin-top: 235px;
"><!-- column -->
        <asp:Button ID="btnPost" runat="server" Text="Post" CssClass="sidecatmenu"  />
          <asp:Button ID="btnVideo" runat="server" Text="Video" CssClass="sidecatmenu"  />
          <asp:Button ID="btnPhoto" runat="server" Text="Photo" CssClass="sidecatmenu" OnClick="btnPhoto_Click"  />
          <asp:Button ID="btnFriend" runat="server" Text="Friend" CssClass="sidecatmenu" OnClick="btnFriend_Click" />
          <asp:Button ID="btnAbout" runat="server" Text="About" CssClass="sidecatmenu"  />
          
       </div>

       
      </div>
     </div>
    </div>
   
   </div>
  </div>
</asp:Content>

