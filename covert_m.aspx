<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="covert_m.aspx.cs" Inherits="Default3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%--<link rel="stylesheet" type="text/css" href="css/covert.css?3910687529" id="pagesheet"/>--%>
   
    <style>
        .ajax__tab_header {
margin-top: -16px;
display:block;}
.ajax__tab_body{
width:430px;
}
    </style>
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
	<%--	<script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js'></script>--%>
		<script src='jquery.autosize.js'></script>
		<script>
		    $(function () {
		        //$('.normal').autosize();
		        //$('.animated').autosize();
		        $('textarea').autosize();
		    });
		</script>
      <script src="js/ajaxupload-min.js"></script>
  
    <link href="css/classicTheme/style.css" rel="stylesheet" />
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_top_menu" Runat="Server">
        <asp:Menu ID="MenuSub" runat="server" Orientation="Horizontal" BorderStyle="Double" CssClass="Menu" OnMenuItemClick="MenuSub_MenuItemClick" style="position: relative; width: auto; float: left;height: 24px;">
            <Items>
                <asp:MenuItem Text="All Time" Value="All Time"></asp:MenuItem>
                <asp:MenuItem Text="Today" Value="Today"></asp:MenuItem>
                <asp:MenuItem Text="Yesterday" Value="Yesterday"></asp:MenuItem>
                <asp:MenuItem Text="More..." Value="More..."></asp:MenuItem>
            </Items>
        </asp:Menu>
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" style="color:White;background-color:#525461;border-radius: 0px 0px 10px 5px;">
            <asp:ListItem>All</asp:ListItem>
            <asp:ListItem>Top 10</asp:ListItem>
            <asp:ListItem>Time</asp:ListItem>
            <asp:ListItem>Bookmark</asp:ListItem>
              <asp:ListItem>Checked</asp:ListItem>
        </asp:DropDownList>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_left_menu" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
      <div class="clearfix colelem" id="u542"><!-- group -->
       <div class="museBGSize grpelem">
                                <asp:Image ID="ImageProfile" runat="server" CssClass="profilephotoborder" Width="130px" Height="116px" />

     </div>  <div class="shadow clearfix grpelem" id="post_item" style=""><!-- group -->
            <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Always">
                <%-- <Triggers>
                     <asp:AsyncPostBackTrigger ControlID="btnNewPost" EventName="Click" />
                   
                    
                 </Triggers>--%>
                 <ContentTemplate>
    
      
          <asp:TextBox ID="txtPostTitle" runat="server" placeholder="Title Name" onfocus="this.placeholder=''" onblur="this.placeholder='Title Name'" style="
    margin-left: 270px;
"></asp:TextBox>
         
         <div style="float:right;margin-bottom:10px">
             <asp:ImageButton ID="ImageButton12" class="icon" runat="server" ImageUrl="~/images/icon/black/tag.png" Width="20" Height="20" style="display: none;"/>
                 <asp:ImageButton ID="ImageButton13" class="icon" runat="server" ImageUrl="~/images/icon/black/location.png" Width="20" style="display: none;"/>
           
               
                 
<%--                 <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/icon/black/attach.png" Width="20" OnClientClick=" clk();" />--%>
                 <asp:ImageButton ID="ImageButton14" runat="server" ImageUrl="~/images/icon/black/emoticon.png" Width="20" Visible="false" />
             </div>
    
                   <ajaxToolkit:TabContainer ID="TabContainerPost" runat="server" CssClass="postboxall" ActiveTabIndex="0" width="132"

           >
                       <ajaxToolkit:TabPanel HeaderText="Text" runat="server">
                           <ContentTemplate>
                                               <asp:TextBox ID="txtNewPost" class='animated' style="width:405px; height:80px; max-height: 300px;margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />

                                <ajaxToolkit:AutoCompleteExtender CompletionListCssClass="AutoExtender" OnClientPopulated="GetFriendImage" OnClientItemSelected="SetTag" ID="AutoCompleteExtender4" runat="server" MinimumPrefixLength="2" ServiceMethod="GetFriendTag" ServicePath="WebService.asmx" TargetControlID="txtNewPost" > </ajaxToolkit:AutoCompleteExtender> 

                                </ContentTemplate>
                       </ajaxToolkit:TabPanel>
                        <ajaxToolkit:TabPanel HeaderText="Photo" runat="server">
                           <ContentTemplate>
                                               <asp:TextBox ID="txtPhotoPost" class='animated' style="width:405px;max-height: 300px;margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />
            <%--   <ajaxToolkit:AsyncFileUpload ThrobberID="imgLoader" CssClass="FileUploadClass" ID="AsyncFileUpload1" runat="server" style="width: 429px;" OnUploadedComplete="AsyncFileUpload1_UploadedComplete" />
<asp:Image ID="imgLoader" CssClass="imgLoader2" runat="server"
        ImageUrl = "~/images/loading2.gif" />--%>

  <div class="photoupload" runat="server" > </div>
                    <asp:HiddenField ID="uploaded_files_photo" runat="server" />
               <asp:HiddenField ID="uploaded_files_type_photo" runat="server" />
                 <script>
                     var types_photo = "";
                     //$('.photoupload').ajaxupload('option', allowExt, ['jpg', 'gif']);
                     $('.photoupload').ajaxupload({
                         url: 'upload.aspx',
                         autoStart: true,
                         maxFileSize: '2G',
                         maxFiles: 1,

                         //allowExt: [jpg,jpeg,bmp],
                         finish: function (d, obj) {

                             $("#<%=uploaded_files_photo.ClientID %>").val(d);

                             for (i = 0; i < obj.length; i++) {
                                 console.log(obj[i].file.type);
                                 types_photo = obj[i].file.type;

                             }

                             $("#<%=uploaded_files_type_photo.ClientID %>").val(types_photo);


                         }
                     });



    </script>

                                </ContentTemplate>
                       </ajaxToolkit:TabPanel>
                        <ajaxToolkit:TabPanel HeaderText="Video" runat="server">
                           <ContentTemplate>
                                               <asp:TextBox ID="txtVideoPost" class='animated' style="width:405px;max-height: 300px;margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />
              <%-- <ajaxToolkit:AsyncFileUpload ThrobberID="imgLoader2" CssClass="FileUploadClass" ID="AsyncFileUpload2" runat="server" style="width: 429px;" OnUploadedComplete="AsyncFileUpload2_UploadedComplete" />
<asp:Image ID="imgLoader2" CssClass="imgLoader2" runat="server"
        ImageUrl = "~/images/loading2.gif" />--%>

  <div class="videoupload" runat="server" > </div>
               <asp:HiddenField ID="uploaded_files_video" runat="server" />
               <asp:HiddenField ID="uploaded_files_type_video" runat="server" />
                 <script>

                     var types_video = "";
                     $('.videoupload').ajaxupload({
                         url: 'upload.aspx',
                         autoStart: true,
                         maxFileSize: '2G',
                         maxFiles: 1,


                         finish: function (d, obj) {

                             $("#<%=uploaded_files_video.ClientID %>").val(d);

                             for (i = 0; i < obj.length; i++) {
                                 console.log(obj[i].file.type);
                                 types_video = obj[i].file.type;

                             }

                             $("#<%=uploaded_files_type_video.ClientID %>").val(types_video);


                         }

                     });

                     </script>

                                </ContentTemplate>
                       </ajaxToolkit:TabPanel>
                       
                   </ajaxToolkit:TabContainer>
                       
          

<%--         <ajaxToolkit:AutoCompleteExtender CompletionListCssClass="AutoExtender" OnClientPopulated="GetFriendImage" OnClientItemSelected="GetFriendProfile" BehaviorID="acExt" ID="AutoCompleteExtenderPostTag" UseContextKey="true" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" runat="server" MinimumPrefixLength="1" ServiceMethod="GetFriendTag" ServicePath="WebService.asmx" TargetControlID="txtNewPost" > </ajaxToolkit:AutoCompleteExtender> --%>

         <%--    <asp:TextBox id="demo" class="tags-input" style="
    border: 1px solid #c4c4c4;
" runat="server"/>--%>
          
              <div style="float:left; display:inline;">
           Post As:<asp:TextBox ID="txtPostedby" runat="server" style="border-width:1px;border-style:solid;width:150px;background-color: rgb(69, 81, 94);color: white;text-align: center;" 

ReadOnly="true">anonymous</asp:TextBox>
            <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True">
                <asp:ListItem>Romantic</asp:ListItem>
                <asp:ListItem>Religious</asp:ListItem>
                <asp:ListItem>Patriotic</asp:ListItem>
                <asp:ListItem>Educational</asp:ListItem>
                <asp:ListItem>Experience</asp:ListItem>
                <asp:ListItem>Travel</asp:ListItem>
                <asp:ListItem>Review</asp:ListItem>
                 <asp:ListItem>Others</asp:ListItem>
            </asp:DropDownList>         
            <%--<asp:Button ID="btnNewPost" runat="server" Text="Post" OnClick="btnNewPost_Click" Width="50px" 

EnableViewState="False" />--%>

        </div>
                  
                <div style="float: right;  ">

                    <asp:ImageButton ID="btnNewPost" CssClass="icon" runat="server" ImageUrl="~/images/icon/black/post.png" Width="20" OnClick="btnNewPost_Click" />
             
       
         <div id="divImagepost" style="display: none;">
                        <div class="spinner" style="margin-left: -50px;margin-top: -49px;">
                            <div class="bounce1"></div>
                            <div class="bounce2"></div>
                            <div class="bounce3"></div>
                        </div>
                    </div></div>
       
 
       

         <div style="float:left; display:inline; position:relative; width: 130px; height:35px;margin-left: -460px;margin-bottom: 10px;">
            <%-- <asp:Panel ID="Panel1" runat="server" Visible="false">
                 <div>
        Choose Your Name:<asp:TextBox ID="TextBox1" runat="server" Width="214px"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="OK" OnClientClick="f2();" />
    </div>
             </asp:Panel>--%>
             <asp:ImageButton ID="ImageButton1" CssClass="icon" runat="server" ImageUrl="~/images/logo_covert.png" margin-top="30px" Width="35px" Height="30px" OnClick="ImageButton1_Click" />
             <asp:ImageButton ID="ImageButton2" CssClass="icon" runat="server" Width="35px" Height="30px" OnClick="ImageButton2_Click" />
          <%--   <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/avatar-female.png" Width="40px" Height="35px" OnClick="ImageButton3_Click" OnClientClick="return popitup('covert_avatar.aspx')"/>--%>
             <asp:ImageButton ID="ImageButton4" OnClientClick="$('html').css('overflow', 'hidden');" CssClass="icon" runat="server" ImageUrl="~/images/avatars/avatar-female.png" Width="35px" Height="30px" />
              </div>
             <div>
        <asp:Panel ID="pnModelPopup" runat="server" CssClass="popup" ScrollBars="Auto" Style="display:none; padding:10px; border-radius:5px; font-weight:bold; font-size:16px;">
         
                Choose Your Avatar:<br />
               <%-- <asp:Repeater ID="RepeaterImages" runat="server" OnItemCommand="RepeaterImages_ItemCommand" OnItemCreated="RepeaterImages_ItemCreated">
    <ItemTemplate>
        <asp:ImageButton ID="Image" Width="100" Height="100" runat="server" ImageUrl='<%# Container.DataItem %>' />
    </ItemTemplate>
</asp:Repeater>--%>
            <br />
             <asp:ImageButton ID="Image" CssClass="icon" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar1.jpg" OnClick="Image_Click1"/>
            <asp:ImageButton ID="ImageButton3" CssClass="icon" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar2.jpg" OnClick="Image_Click1"/>
            <asp:ImageButton ID="ImageButton5" CssClass="icon" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar3.jpg" OnClick="Image_Click1"/><br />
            <asp:ImageButton ID="ImageButton6" CssClass="icon" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar4.jpg" OnClick="Image_Click1"/>
            <asp:ImageButton ID="ImageButton7" CssClass="icon" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar5.jpg" OnClick="Image_Click1"/>
            <asp:ImageButton ID="ImageButton8" CssClass="icon" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar6.jpg" OnClick="Image_Click1"/><br />
            <asp:ImageButton ID="ImageButton9" CssClass="icon" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar7.jpg" OnClick="Image_Click1"/>
            <asp:ImageButton ID="ImageButton10" CssClass="icon" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar8.jpg" OnClick="Image_Click1"/>
            <asp:ImageButton ID="ImageButton11" CssClass="icon" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar9.jpg" OnClick="Image_Click1"/><br />
          
                 Choose Your Name:<asp:TextBox ID="TextBox1" runat="server" style="width:214px;border: 1px solid gray;"></asp:TextBox><br />
                            <asp:Button ID="Button1" runat="server" style="height: 30px;width: 70px;background-color: #26284f;color: white;margin-bottom: 5px;" OnClick="Button1_Click" Text="OK" />
             
                        <asp:Button ID="btnCancel" runat="server" style="height: 30px;width: 70px;background-color: #26284f;color: white;margin-bottom: 5px;" Text="Cancel" />
                  
        </asp:Panel>
        <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="ModalPopupExtender1" runat="server" PopupControlID="pnModelPopup" TargetControlID="ImageButton4"                                      
             DropShadow="true" BackgroundCssClass="modalBackground"
            CancelControlID="btnCancel" Drag="false">
        </ajaxToolkit:ModalPopupExtender>
        <%--<div style="margin-left: 300px">
            <asp:LinkButton ID="lnkbtnSignin" runat="server">Sign in</asp:LinkButton>
        </div>--%>
    </div>
                     
                       </ContentTemplate>
</asp:UpdatePanel>
                   </div>
         <%--<ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender3"
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
        
        
      <div class="clearfix colelem" id="pu872" style=""><!-- group -->
       <div class="clearfix grpelem" id="u872"><!-- column -->
             <div>
 <asp:UpdatePanel ID="UpdatePanel1" runat="server"
 UpdateMode="Conditional">
 <ContentTemplate>

        <asp:ListView ID="ListView1" runat="server" DataSourceID="CovertDataSource" DataKeyNames="PhotoID,LikeId,UserId,ContentType,Privacy" GroupItemCount="1" OnItemCreated="ListView1_ItemCreated" OnItemDataBound="ListView1_ItemDataBound" OnItemCommand="ListView1_ItemCommand">
           
            <EditItemTemplate>
                <td runat="server"><%--CovertId:
                    <asp:TextBox ID="CovertIdTextBox" runat="server" Text='<%# Bind("CovertId") %>' />--%>
                    
                    
                   <%-- <br />CovertPostDate:
                    <asp:TextBox ID="CovertPostDateTextBox" runat="server" Text='<%# Bind("CovertPostDate") %>' />
                    <br />CovertPostUser:
                    <asp:TextBox ID="CovertPostUserTextBox" runat="server" Text='<%# Bind("CovertPostUser") %>' />
                    <br />--%>
                    
                    <br />

                    <div class="colelem post_section_full_grid"><!-- post section -->
                   <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                         <%--<asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' Visible="false" />--%>
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo" style="
    margin-top: 0px;
">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "AvatarHandlerPhoto.ashx?id=" + Eval("PhotoID") %>' />

            </div>

               <div class="post_top_info">
                <div class="post_edit_delete" style="margin-right: -10px;margin-top: -4px;">
                           <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                      <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you Sure you Want to delete ?"
                                        TargetControlID="DeleteButton">
                                    </ajaxToolkit:ConfirmButtonExtender>  
                     </div>
                   <asp:HyperLink ID="CovertPostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' />

                   <br />
              
                   <asp:Label ID="CovertPostDateLabel" style="font-size: 12px;" runat="server" Text='<%# Eval("Date") %>' />
                   <br />
                         </div>
                   
            <div class="colelem post_section">
                  <asp:TextBox ID="CovertPostTextBox" runat="server" Text='<%# Bind("Post") %>' Width="268" />
                   <br /></div>
               <div style="margin:10px;margin-bottom:0px">
               <asp:Button ID="UpdateButton" runat="server" CommandName="Updatepost" Text="Update" />
                    
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" /></div>
           </div>
                      <div class="colelem like_dislike_share_section">
                      <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                            <br />
                           <asp:Button ID="LinkViewAllComment" runat="server" style="border-width: 1px;width: 270px;background-color: #535461;color: white; border-radius: 5px;" Visible="true" Text="View all comments" CommandName="allcomment"></asp:Button>
                           </div>

          
                       <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                            </div>
                </td>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                    <tr>
                        <td>No covert post found</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EmptyItemTemplate>
<td runat="server" />
            </EmptyItemTemplate>
            <GroupTemplate>
                <tr id="itemPlaceholderContainer" runat="server">
                    <td id="itemPlaceholder" runat="server"></td>
                </tr>
            </GroupTemplate>
            <GroupSeparatorTemplate>
          <td runat="server" >&nbsp;</td>
        </GroupSeparatorTemplate>
            <%--<InsertItemTemplate>
                <td runat="server" style="">CovertId:
                    <asp:TextBox ID="CovertIdTextBox" runat="server" Text='<%# Bind("CovertId") %>' />
                    <br />CovertPost:
                    <asp:TextBox ID="CovertPostTextBox" runat="server" Text='<%# Bind("CovertPost") %>' />
                    <br />CovertPostDate:
                    <asp:TextBox ID="CovertPostDateTextBox" runat="server" Text='<%# Bind("CovertPostDate") %>' />
                    <br />CovertPostUser:
                    <asp:TextBox ID="CovertPostUserTextBox" runat="server" Text='<%# Bind("CovertPostUser") %>' />
                    <br />
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                    <br />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                    <br /></td>
            </InsertItemTemplate>--%>
            <ItemTemplate>
              
                <td id="tdPwd"  >
                      <asp:Panel runat="server" id="items" >
                     <%--CovertId:<asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>' Visible="true" />--%>
                 <div class="colelem post_section_full_grid"><!-- post section -->
                   <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' OnInit="CovertIdLabel_Init" Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                      <asp:Label ID="PhotoIDLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                         <%--<asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' Visible="false" />--%>
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo" style="
    margin-top: 0px;
">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "AvatarHandlerPhoto.ashx?id=" + Eval("PhotoID") %>' />

            </div>

               <div class="post_top_info">
                <div class="post_edit_delete" style="margin-right: -10px;margin-top: -4px;">
                                  <asp:ImageButton ID="BookmarkButton" CssClass="icon" ImageUrl="~/images/icon/black/bookmark.png" style="width: 15px;margin-right: 5px;" runat="server" CommandName="Bookmarkpost" AlternateText="Bookmark" />

                           <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                   <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you Sure you Want to delete ?"
                                        TargetControlID="DeleteButton">
                                    </ajaxToolkit:ConfirmButtonExtender>
                       <%--<ajaxToolkit:AnimationExtender ID="AnimationExtender3" runat="server" TargetControlID="DeleteButton">
            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="items" Duration="1" Fps="30">
                <FadeOut AnimationTarget="items" Fps="30" />
                
            </Parallel>
           
           </OnClick>
            </Animations>
        </ajaxToolkit:AnimationExtender>--%>
                       </div>
                    <asp:Label ID="CovertPostUserName" runat="server" Text='<%# Eval("UserName") %>' Visible="false" />
                   <asp:HyperLink ID="CovertPostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' />
                   <br />
              
                   <asp:Label ID="CovertPostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                   <br />
                         </div>
                   
            <div class="colelem post_section">
                 Title: <asp:Label ID="Label1" runat="server" Text='<%# Eval("Title") %>' /><br />
                   <asp:Literal ID="CovertPostLabel" runat="server" Text='<%# AddEmotes( Eval("Post").ToString()) %>' />
                   <br /></div>
               
           </div>
                      <div class="colelem like_dislike_share_section">
                      <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                            <br />
                           <asp:Button ID="LinkViewAllComment" runat="server" style="border-width: 1px;width: 270px;background-color: #535461;color: white; border-radius: 5px;" Visible="true" Text="View all comments" CommandName="allcomment"></asp:Button>
                          <ajaxToolkit:AnimationExtender ID="AnimationExtender1" runat="server" TargetControlID="LinkViewAllComment">
            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="PanelPostComment" Duration="3" Fps="25">
                <FadeOut AnimationTarget="PanelPostComment" minimumOpacity=".1" Fps="30" />
                <FadeIn AnimationTarget="PanelPostComment" minimumOpacity=".1" Fps="30" />  
            </Parallel>
           
           </OnClick>
            </Animations>
        </ajaxToolkit:AnimationExtender>
                           </div>

          
                       <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                            </div>
                    <asp:Panel ID="PanelPostComment" runat="server">
                    <asp:ListView ID="ListView2" runat="server" DataKeyNames="CommentId,LikeId" DataSourceID="MediaDS" InsertItemPosition="LastItem" OnItemInserting="lvMediaComment_ItemInserting" OnItemCreated="ListView2_ItemCreated" OnItemCommand="ListView2_ItemCommand">
           
             <EditItemTemplate>
                 <span style="">CommentId:
                 <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                 <br />
                 Comment:
                 <asp:TextBox ID="CommentTextBox" class='animated' TextMode="MultiLine" style="width:200px" runat="server" Text='<%# Bind("Comment") %>' />
                 <br />
                 CommentUser:
                 <asp:TextBox ID="CommentUserTextBox" runat="server" Text='<%# Bind("CommentUser") %>' />
                 <br />
                 CommentDate:
                 <asp:TextBox ID="CommentDateTextBox" runat="server" Text='<%# Bind("CommentDate") %>' />
                 <br />
                 CovertId:
                 <asp:TextBox ID="CovertIdTextBox" runat="server" Text='<%# Bind("CovertId") %>' />
                 <br />
                 <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                 <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                 <br /><br /></span>
             </EditItemTemplate>
             <EmptyDataTemplate>
                 <span>No data was returned.</span>
             </EmptyDataTemplate>
             <InsertItemTemplate>
                  <asp:panel defaultbutton="InsertButton" runat="server">
                <span style="">
                   <div class="colelem comment_new_full" style="margin-top: -7px;">
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
                    

                        </div>
                <div class="comment_new_section" style="
    height: 88px;
">
                
<asp:TextBox ID="CommentTextBox" class='animated' style="width:190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" Text='<%# Bind("Comment") %>' /> 
                  <asp:Button ID="InsertButton" runat="server" style="margin-left: 139px;height: 30px;width: 70px;background-color: #26284f;color: white;" CommandName="Insert" Text="Comment" />
                </div>
              
                
               <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                </div>
                </span>
                      </asp:panel>
             </InsertItemTemplate>
             <ItemTemplate>
                  
                  <span style="">
                     <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                    <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />

                  
                 <div class="colelem comment_post_full">
                     <div class="position_content" >
           <div class=" grpelem comment_post_profile_photo" style="
    margin-top: 0px;
">
                <asp:ImageButton ID="ImageProfile2" runat="server" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">

                <asp:HyperLink ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' /><br />
                <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                        
                     <div class="colelem comment_post_section">
                   <asp:Literal ID="CommentLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="comment_post_like_section" style="
    margin-top: 10px;
">
              <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                       <%--<asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                     <hr />
                            
          </div>
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
                 <span style="">CommentId:
                 <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                 <br />
                 Comment:
                 <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                 <br />
                 CommentUser:
                 <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' />
                 <br />
                 CommentDate:
                 <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                 <br />
                 CovertId:
                 <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' />
                 <br />
<br /></span>
             </SelectedItemTemplate>
                        
         </asp:ListView>
                    </asp:Panel>
                             </asp:Panel>
                    </td>
             
            </ItemTemplate>
            <ItemSeparatorTemplate>
          <td runat="server" >&nbsp;&nbsp;</td>
                 </ItemSeparatorTemplate>
            <LayoutTemplate>
                <table runat="server"  >
                    <tr runat="server" >
                        
                        <td runat="server" >
                            <table id="groupPlaceholderContainer" runat="server" border="1" style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <tr id="groupPlaceholder" runat="server" >
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style="text-align: center;background-color: #5D7B9D;font-family: Verdana, Arial, Helvetica, sans-serif;color: #FFFFFF;" ></td>
                    </tr>
                </table>
                
            </LayoutTemplate>
            <%--<SelectedItemTemplate>
                <td runat="server" style="background-color: #E2DED6;font-weight: bold;color: #333333;">CovertId:
                    <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>' />
                    <br />CovertPost:
                    <asp:Label ID="CovertPostLabel" runat="server" Text='<%# Eval("CovertPost") %>' />
                    <br />CovertPostDate:
                    <asp:Label ID="CovertPostDateLabel" runat="server" Text='<%# Eval("CovertPostDate") %>' />
                    <br />CovertPostUser:
                    <asp:Label ID="CovertPostUserLabel" runat="server" Text='<%# Eval("CovertPostUser") %>' />
                    <br /></td>
            </SelectedItemTemplate>--%>
            
           </asp:ListView>
           
           <asp:SqlDataSource ID="CovertDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="CovertDataSource_Selecting" SelectCommand="SELECT * FROM [CovertPosts] ORDER BY [CovertPostDate] DESC"></asp:SqlDataSource>
      <asp:SqlDataSource ID="CovertCommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [CovertComments] WHERE ([CovertId] = @CovertId) ORDER BY [CommentDate]" OnSelecting="CovertCommentDataSource_Selecting">
             <SelectParameters>
                 <asp:Parameter Name="CovertId" Type="Object" />
             </SelectParameters>
         </asp:SqlDataSource>
           <asp:SqlDataSource ID="MediaDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [PhotoComments] WHERE ([PhotoID] = @PhotoID) ORDER BY [CommentDate]" OnSelecting="MediaDS_Selecting">
                 <SelectParameters>
                     <asp:Parameter Name="PhotoID" Type="Object" />
                     
                 </SelectParameters>
             </asp:SqlDataSource>
           </ContentTemplate>
     <Triggers>

      <asp:AsyncPostBackTrigger ControlID="LoadMore" EventName="Click">

    </asp:AsyncPostBackTrigger>
          <asp:AsyncPostBackTrigger ControlID="btnNewPost" EventName="Click"></asp:AsyncPostBackTrigger>

   </Triggers>
 </asp:UpdatePanel>
     </div>


             </div>
       
      

       <%--  <div class="clearfix colelem" id="media_post_divider"><!-- group -->--%>
       <div class="clearfix grpelem" id="media_post_section" style="margin-top: 10px;"><!-- column -->
             <div>
 <asp:UpdatePanel ID="UpdatePanel2" runat="server"
 UpdateMode="Conditional">
 <ContentTemplate>

        <asp:ListView ID="ListView3" runat="server" DataSourceID="CovertMediaDataSource" DataKeyNames="PhotoID,LikeId,UserId,ContentType" GroupItemCount="1" OnItemCreated="ListView3_ItemCreated" OnItemDataBound="ListView3_ItemDataBound" OnItemCommand="ListView3_ItemCommand">
           
            <EditItemTemplate>
                <td runat="server"><%--CovertId:
                    <asp:TextBox ID="CovertIdTextBox" runat="server" Text='<%# Bind("CovertId") %>' />--%>
                   
                    
                   <%-- <br />CovertPostDate:
                    <asp:TextBox ID="CovertPostDateTextBox" runat="server" Text='<%# Bind("CovertPostDate") %>' />
                    <br />CovertPostUser:
                    <asp:TextBox ID="CovertPostUserTextBox" runat="server" Text='<%# Bind("CovertPostUser") %>' />
                    <br />--%>
                   

                    <div class="colelem post_section_full_grid" style="background-color:white;"><!-- post section -->
                   <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' OnInit="CovertIdLabel_Init" Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                         <%--<asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' Visible="false" />--%>
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo" style="
    margin-top: 0px;
">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "AvatarHandlerPhoto.ashx?id=" + Eval("PhotoID") %>' />

            </div>

               <div class="post_top_info">
               <div class="post_edit_delete" style="margin-right: -10px;margin-top: -4px;">
                                 <asp:ImageButton ID="BookmarkButton" CssClass="icon" ImageUrl="~/images/icon/black/bookmark.png" style="width: 15px;margin-right: 5px;" runat="server" CommandName="Bookmarkpost" AlternateText="Bookmark" />

                           <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                 <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you Sure you Want to delete ?"
                                        TargetControlID="DeleteButton">
                                    </ajaxToolkit:ConfirmButtonExtender>        
               </div>
                   <asp:Label ID="CovertPostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' />
                   <br />
              
                   <asp:Label ID="CovertPostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                   <br />
                         </div>
                    <div class="post_media_section">
                   
                <video id="embed2" controls="controls" src='<%# Eval("ImageUrl") %>' width="268" height="240"></video>
                
                    </div>
            <div class="colelem post_section">
                  <asp:TextBox ID="CovertPostTextBox" runat="server" Text='<%# Bind("Description") %>' Width="268" BorderColor="Black" BorderStyle="Solid" BorderWidth="1" />
                   <br /></div>
               <div style="margin:10px">
                <asp:Button ID="UpdateButton" runat="server" CommandName="Updatepost" Text="Update" />
                  
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                  </div>
           </div>
                      <div class="colelem like_dislike_share_section">
                      <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                            <br />
                           <asp:Button ID="LinkViewAllComment" runat="server" style="border-width: 1px;width: 270px;background-color: #535461;color: white; border-radius: 5px;" Visible="true" Text="View all comments" CommandName="allcomment"></asp:Button>
                           </div>

          
                       <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                            </div>
                </td>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                    <tr>
                        <td>No covert post found</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EmptyItemTemplate>
<td runat="server" />
            </EmptyItemTemplate>
            <GroupTemplate>
                <tr id="itemPlaceholderContainer" runat="server">
                    <td id="itemPlaceholder" runat="server"></td>
                </tr>
            </GroupTemplate>
            <GroupSeparatorTemplate>
          <td runat="server" >&nbsp;</td>
        </GroupSeparatorTemplate>
            <%--<InsertItemTemplate>
                <td runat="server" style="">CovertId:
                    <asp:TextBox ID="CovertIdTextBox" runat="server" Text='<%# Bind("CovertId") %>' />
                    <br />CovertPost:
                    <asp:TextBox ID="CovertPostTextBox" runat="server" Text='<%# Bind("CovertPost") %>' />
                    <br />CovertPostDate:
                    <asp:TextBox ID="CovertPostDateTextBox" runat="server" Text='<%# Bind("CovertPostDate") %>' />
                    <br />CovertPostUser:
                    <asp:TextBox ID="CovertPostUserTextBox" runat="server" Text='<%# Bind("CovertPostUser") %>' />
                    <br />
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                    <br />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                    <br /></td>
            </InsertItemTemplate>--%>
            <ItemTemplate>
               
                <td id="tdPwd"  >
                     <asp:Panel runat="server" id="items" >
                     <%--CovertId:<asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>' Visible="true" />--%>
                 <div class="colelem post_section_full_grid" style="background-color:white;"><!-- post section -->
                   <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' OnInit="CovertIdLabel_Init" Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                 <asp:Label ID="PhotoIDLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                         <%--<asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' Visible="false" />--%>
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo" style="
    margin-top: 0px;
">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "AvatarHandlerPhoto.ashx?id=" + Eval("PhotoID") %>' />

            </div>

               <div class="post_top_info">
               <div class="post_edit_delete" style="margin-right: -10px;margin-top: -4px;">
                                 <asp:ImageButton ID="BookmarkButton" CssClass="icon" ImageUrl="~/images/icon/black/bookmark.png" style="width: 15px;margin-right: 5px;" runat="server" CommandName="Bookmarkpost" AlternateText="Bookmark" />

                           <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                   <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you Sure you Want to delete ?"
                                        TargetControlID="DeleteButton">
                                    </ajaxToolkit:ConfirmButtonExtender>
                     <%--<ajaxToolkit:AnimationExtender ID="AnimationExtender3" runat="server" TargetControlID="DeleteButton">
            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="items" Duration="1" Fps="30">
                <FadeOut AnimationTarget="items" Fps="30" />
                
            </Parallel>
           
           </OnClick>
            </Animations>
        </ajaxToolkit:AnimationExtender>--%>
                       </div>
                 
                    <asp:Label ID="CovertPostUserName" runat="server" Text='<%# Eval("UserName") %>' Visible="false" />
                   <asp:HyperLink ID="CovertPostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' />
                   <br />
              
                   <asp:Label ID="CovertPostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                   <br />
                         </div>
                    <div class="post_media_section">
                    <asp:Panel runat="server" Visible="false" ID="pnlVideo" style="height: 235px;">
                <video runat="server" id="videoplayer" style="height: 220px;width: 268px;" controls="controls" src='<%# Eval("ImageUrl") %>'></video>
                       </asp:Panel>               <a class='inline' href="#inline_content" runat="server" id="photo_popup">       
                         <asp:ImageButton ID="imgbtn" Width="200" Height="200"  runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Visible="false" style="
    margin-left: 35px;
" /></a>
<%--                          <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="MPEPopImage" CancelControlID="btnClose"  DropShadow="true"  BackgroundCssClass="modalBackgroundImage" Drag="false" runat="server" TargetControlID="imgbtn" PopupControlID="Panel1"></ajaxToolkit:ModalPopupExtender>--%>
                 <div style='display:none'>
			<div id='inline_content' style='padding:10px; background:#fff;' runat="server">
                           <asp:Panel ID="Panel1" runat="server" style="margin-top: 50px;z-index: 10000; height: 500px; opacity: 1; box-shadow: rgb(0, 0, 0) 5px 5px 5px; background-color: white;">
                             <div style="float:left">
              <asp:Image Width="700" Height="500" ID="ImageButton2" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' />

                             </div>
                            <div style="float:right;margin:20px;">
                                 <asp:Button ID="btnClose" runat="server" Text="X" style="margin-left: -735px;display: block;clear: both;width: 30px;height: 30px;border-radius: 300px;margin-top: -34px;border: 6px solid rgb(242, 243, 244);background: rgb(204, 222, 232);color: rgb(10, 22, 45);font-weight: bold;margin-top: -38px;" />
                           <asp:ImageButton ID="Image2" runat="server" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' Style="vertical-align:top" />
<%--                                            <asp:HyperLink ID="FullNameLabel" runat="server" Text='<%# Eval("FirstName") %>' NavigateUrl='<%# Eval("UserId","~/profile-list_search.aspx?userid={0}") %>' />--%>
                                                      <asp:HyperLink ID="HyperLink2" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' /> 
<br />
                       
                                <asp:Label ID="DateCreatedLabel" runat="server" style="display: block;margin-left: 56px;margin-top: -16px;" Text='<%# Eval("Date") %>' /><br />
                                <asp:Label ID="Label2" runat="server" style="margin-bottom: 20px;display: block;margin-top: 5px;" Text='<%# Eval("Description") %>' /><br />
                              
                               <asp:ListView ID="ListView5" runat="server" DataKeyNames="CommentId,LikeId" DataSourceID="MediaDS" InsertItemPosition="LastItem" OnItemInserting="lvMediaComment_ItemInserting" OnItemCreated="ListView4_ItemCreated" OnItemCommand="ListView4_ItemCommand">
           
             <EditItemTemplate>
                 <span style="">CommentId:
                 <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                 <br />
                 Comment:
                 <asp:TextBox ID="CommentTextBox" class='animated' TextMode="MultiLine" style="width:200px" runat="server" Text='<%# Bind("Comment") %>' />
                 <br />
                 CommentUser:
                 <asp:TextBox ID="CommentUserTextBox" runat="server" Text='<%# Bind("CommentUser") %>' />
                 <br />
                 CommentDate:
                 <asp:TextBox ID="CommentDateTextBox" runat="server" Text='<%# Bind("CommentDate") %>' />
                 <br />
                 CovertId:
                 <asp:TextBox ID="CovertIdTextBox" runat="server" Text='<%# Bind("CovertId") %>' />
                 <br />
                 <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                 <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                 <br /><br /></span>
             </EditItemTemplate>
             <EmptyDataTemplate>
                 <span>No data was returned.</span>
             </EmptyDataTemplate>
             <InsertItemTemplate>
                  <asp:panel defaultbutton="InsertButton" runat="server">
                <span style="">
                   <div class="colelem comment_new_full" style="margin-bottom:0px">
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
                    

                        </div>
                <div class="comment_new_section" style="
    height: 88px;
">
                
<asp:TextBox ID="CommentTextBox" class='animated' style="width:190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" Text='<%# Bind("Comment") %>' /> 
                  <asp:Button ID="InsertButton" runat="server" style="margin-left: 139px;height: 30px;width: 70px;background-color: #26284f;color: white;" CommandName="Insert" Text="Comment" />
                </div>
              
                
               <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                </div>
                </span>
                      </asp:panel>
             </InsertItemTemplate>
             <ItemTemplate>
                  
                  <span style="">
                     <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                    <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />

                  
                 <div class="colelem comment_post_full">
                     <div class="position_content" >
           <div class=" grpelem comment_post_profile_photo" style="
    margin-top: 0px;
">
                <asp:ImageButton ID="ImageProfile2" runat="server" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">
                <asp:HyperLink ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' /><br />
                <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                        
                     <div class="colelem comment_post_section">
                   <asp:Literal ID="CommentLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="comment_post_like_section" style="
    margin-top: 10px;
">
              <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                       <%--<asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                        <hr />    
          </div>
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
                 <span style="">CommentId:
                 <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                 <br />
                 Comment:
                 <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                 <br />
                 CommentUser:
                 <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' />
                 <br />
                 CommentDate:
                 <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                 <br />
                 CovertId:
                 <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>' />
                 <br />
<br /></span>
             </SelectedItemTemplate>
                        
         </asp:ListView>
                            
                               </div>
                       </asp:Panel>
                </div></div>
                    </div>
            <div class="colelem post_section">
                 Title: <asp:Label ID="Label1" runat="server" Text='<%# Eval("Title") %>' /> <br />
                   <asp:Literal ID="CovertPostLabel" runat="server" Text='<%# AddEmotes( Eval("Description").ToString()) %>' /><br />
                                                          <asp:HyperLink  CssClass="one" ID="HyperLink1" NavigateUrl='<%# Eval("Link") %>' runat="server"><%# Eval("Link") %></asp:HyperLink>

                   <br /></div>
               
           </div>
                      <div class="colelem like_dislike_share_section">
                      <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                            <br />
                           <asp:Button ID="LinkViewAllComment" runat="server" style="border-width: 1px;width: 270px;background-color: #535461;color: white; border-radius: 5px;" Visible="true" Text="View all comments" CommandName="allcomment"></asp:Button>
                          <ajaxToolkit:AnimationExtender ID="AnimationExtender1" runat="server" TargetControlID="LinkViewAllComment">
            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="PanelMediaComment" Duration="3" Fps="25">
                <FadeOut AnimationTarget="PanelMediaComment" minimumOpacity=".1" Fps="30" />
                <FadeIn AnimationTarget="PanelMediaComment" minimumOpacity=".1" Fps="30" />  
            </Parallel>
           
           </OnClick>
            </Animations>
        </ajaxToolkit:AnimationExtender>
                           </div>

          
                       <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                            </div>
                    <asp:Panel ID="PanelMediaComment" runat="server">
                    <asp:ListView ID="ListView4" runat="server" DataKeyNames="CommentId,LikeId" DataSourceID="MediaDS" InsertItemPosition="LastItem" OnItemInserting="lvMediaComment_ItemInserting" OnItemCreated="ListView4_ItemCreated" OnItemCommand="ListView4_ItemCommand">
           
             <EditItemTemplate>
                 <span style="">CommentId:
                 <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                 <br />
                 Comment:
                 <asp:TextBox ID="CommentTextBox" class='animated' TextMode="MultiLine" style="width:200px" runat="server" Text='<%# Bind("Comment") %>' />
                 <br />
                 CommentUser:
                 <asp:TextBox ID="CommentUserTextBox" runat="server" Text='<%# Bind("CommentUser") %>' />
                 <br />
                 CommentDate:
                 <asp:TextBox ID="CommentDateTextBox" runat="server" Text='<%# Bind("CommentDate") %>' />
                 <br />
                 CovertId:
                 <asp:TextBox ID="CovertIdTextBox" runat="server" Text='<%# Bind("PhotoID") %>' />
                 <br />
                 <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                 <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                 <br /><br /></span>
             </EditItemTemplate>
             <EmptyDataTemplate>
                 <span>No data was returned.</span>
             </EmptyDataTemplate>
             <InsertItemTemplate>
                  <asp:panel defaultbutton="InsertButton" runat="server">
                <span style="">
                   <div class="colelem comment_new_full" style="margin-bottom:0px">
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
                    

                        </div>
                <div class="comment_new_section" style="
    height: 88px;
">
                
<asp:TextBox ID="CommentTextBox" class='animated' style="width:190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" Text='<%# Bind("Comment") %>' /> 
                  <asp:Button ID="InsertButton" runat="server" style="margin-left: 139px;height: 30px;width: 70px;background-color: #26284f;color: white;" CommandName="Insert" Text="Comment" />
                </div>
              
                
               <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                </div>
                </span>
                      </asp:panel>
             </InsertItemTemplate>
             <ItemTemplate>
                  
                  <span style="">
                     <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                    <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />

                  
                 <div class="colelem comment_post_full">
                     <div class="position_content" >
           <div class=" grpelem comment_post_profile_photo" style="
    margin-top: 0px;
">
                <asp:ImageButton ID="ImageProfile2" runat="server" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">
                <asp:HyperLink ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' /><br />
                <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                        
                     <div class="colelem comment_post_section">
                   <asp:Literal ID="CommentLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="comment_post_like_section" style="
    margin-top: 10px;
">
              <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                       <%--<asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                        <hr />    
          </div>
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
                 <span style="">CommentId:
                 <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                 <br />
                 Comment:
                 <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                 <br />
                 CommentUser:
                 <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' />
                 <br />
                 CommentDate:
                 <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                 <br />
                 CovertId:
                 <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>' />
                 <br />
<br /></span>
             </SelectedItemTemplate>
                        
         </asp:ListView>
                        </asp:Panel>
                     </asp:Panel>
                    </td>
               
            </ItemTemplate>
            <ItemSeparatorTemplate>
          <td runat="server" >&nbsp;&nbsp;</td>
                 </ItemSeparatorTemplate>
            <LayoutTemplate>
                <table runat="server"  >
                    <tr runat="server" >
                        
                        <td runat="server" >
                            <table id="groupPlaceholderContainer" runat="server" border="1" style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <tr id="groupPlaceholder" runat="server" >
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style="text-align: center;background-color: #5D7B9D;font-family: Verdana, Arial, Helvetica, sans-serif;color: #FFFFFF;" ></td>
                    </tr>
                </table>
                
            </LayoutTemplate>
            <%--<SelectedItemTemplate>
                <td runat="server" style="background-color: #E2DED6;font-weight: bold;color: #333333;">CovertId:
                    <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>' />
                    <br />CovertPost:
                    <asp:Label ID="CovertPostLabel" runat="server" Text='<%# Eval("CovertPost") %>' />
                    <br />CovertPostDate:
                    <asp:Label ID="CovertPostDateLabel" runat="server" Text='<%# Eval("CovertPostDate") %>' />
                    <br />CovertPostUser:
                    <asp:Label ID="CovertPostUserLabel" runat="server" Text='<%# Eval("CovertPostUser") %>' />
                    <br /></td>
            </SelectedItemTemplate>--%>
            
           </asp:ListView>
           
           <asp:SqlDataSource ID="CovertMediaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="CovertMediaDataSource_Selecting" SelectCommand="SELECT * FROM [CovertPosts] ORDER BY [CovertPostDate] DESC"></asp:SqlDataSource>
      <asp:SqlDataSource ID="CovertMediaCommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [CovertComments] WHERE ([CovertId] = @CovertId) ORDER BY [CommentDate]" OnSelecting="CovertMediaCommentDataSource_Selecting">
             <SelectParameters>
                 <asp:Parameter Name="CovertId" Type="Object" />
             </SelectParameters>
         </asp:SqlDataSource>
          
           </ContentTemplate>
     <Triggers>

      <asp:AsyncPostBackTrigger ControlID="LoadMore" EventName="Click">

    </asp:AsyncPostBackTrigger>
          <asp:AsyncPostBackTrigger ControlID="btnNewPost" EventName="Click"></asp:AsyncPostBackTrigger>

   </Triggers>
 </asp:UpdatePanel>
     </div>


             </div>
       
     <div class="clearfix colelem">
             <asp:Button ID="LoadMore" runat="server" Height="28px" Text="Load More..." Width="300" style="display:none" OnClick="LoadMore_Click" />
            <div id="divImage" style="display:none">
                <div class="spinner" style="
    margin-left: 270px;
">
                    <div class="bounce1"></div>
                    <div class="bounce2"></div>
                    <div class="bounce3"></div>
                </div>

            </div>
        </div>
              <ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender1"
        TargetControlID="UpdatePanel2" runat="server">
        <Animations>
            <OnUpdating>
               <Parallel duration="0">
                    <ScriptAction Script="onUpdating();" />
                                    
                </Parallel>
            </OnUpdating>
            <OnUpdated>
                <Parallel duration="0">
                    <ScriptAction Script="onUpdated();" />
                    <FadeOut Duration="1.5" Fps="24" AnimationTarget="ContentPlaceHolder1_ListView3_items_0" />
     <FadeIn Duration="1.5" Fps="24"  AnimationTarget="ContentPlaceHolder1_ListView3_items_0" />
                  
                </Parallel>
            </OnUpdated>
        </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
           <ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender2"
        TargetControlID="UpdatePanel1" runat="server">
        <Animations>
            <OnUpdating>
               <Parallel duration="0">
                    <ScriptAction Script="onUpdating();" />
                                    
                </Parallel>
            </OnUpdating>
            <OnUpdated>
                <Parallel duration="0">
                    <ScriptAction Script="onUpdated();" />
                    <FadeOut Duration="1.5" Fps="24" AnimationTarget="ContentPlaceHolder1_ListView1_items_0" />
     <FadeIn Duration="1.5" Fps="24"  AnimationTarget="ContentPlaceHolder1_ListView1_items_0" />
                  
                </Parallel>
            </OnUpdated>
        </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
         
         </div>

     
               
     <div class="clearfix grpelem" id="divider_right_covert" style="margin-left: 645px;"><!-- group -->
         <div id="listgrid_bar" style="width: 135px;	margin-left: 5px; margin-top: -10px;	position: relative;    float:left;">
         <asp:ImageButton ID="ImageButtonGrid" runat="server" CssClass="" ImageUrl="~/images/icon/black/horizontal20.png" OnClick="ImageButtonGrid_Click" Height="40px" Width="40px"   />
             <asp:ImageButton ID="ImageButtonList" runat="server" CssClass="" ImageUrl="~/images/icon/black/six15.png" OnClick="ImageButtonList_Click" Height="40px" Width="40px"   />
            
             
           <asp:ImageButton ID="btnChangeBackground" OnClientClick="$('html').css('overflow', 'hidden');" runat="server" Height="40" Width="40" Text="Change Background" ImageUrl="~/images/icon/black/photo146.png"  />

      <asp:Panel ID="pnChangeBackground" runat="server" CssClass="popup2" Style="display:none;">
         
                Choose Your Background:<br />
              
          <ajaxToolkit:AjaxFileUpload ID="AjaxFileUpload1" runat="server" OnUploadComplete="AjaxFileUpload1_UploadComplete" 

OnClientUploadComplete="OnClientUploadComplete" MaximumNumberOfFiles="1" AllowedFileTypes="jpg,jpeg,tiff,png,gif"/>

        <asp:Button ID="btnbckcancel" runat="server" Text="Cancel" />
            
        </asp:Panel>
        <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="ModalPopupExtender2" runat="server" PopupControlID="pnChangeBackground" 

TargetControlID="btnChangeBackground"                                      
             DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnbckcancel"
              Drag="false">
        </ajaxToolkit:ModalPopupExtender>
             
             
              </div>
      <div class="clearfix grpelem" id="side_menu_list" style="margin-top: 130px;margin-left: -6px;"><!-- column -->
       
           <asp:Button ID="Button2" runat="server" Text="Romantic" CssClass="sidecatmenu" OnClick="btnRomantic_Click" />
          <asp:Button ID="Button3" runat="server" Text="Religious" CssClass="sidecatmenu" OnClick="btnReligious_Click" />
          <asp:Button ID="Button4" runat="server" Text="Patriotic" CssClass="sidecatmenu" OnClick="btnPatriotic_Click" />
          <asp:Button ID="Button5" runat="server" Text="Educational" CssClass="sidecatmenu" OnClick="btnEducational_Click" />
          <asp:Button ID="Button6" runat="server" Text="Experience" CssClass="sidecatmenu" OnClick="btnExperience_Click" />
          <asp:Button ID="Button7" runat="server" Text="Travel" CssClass="sidecatmenu" OnClick="btnTravel_Click" />
          <asp:Button ID="Button8" runat="server" Text="Review" CssClass="sidecatmenu" OnClick="btnReview_Click" />
          <asp:Button ID="Button9" runat="server" Text="Others" CssClass="sidecatmenu" OnClick="Button9_Click1"/>
       
      </div>
     
     </div>
     

</asp:Content>

