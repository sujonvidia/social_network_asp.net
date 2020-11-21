<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="covert-list_time.aspx.cs" Inherits="Default5" %>

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
   
    <link href="css/classicTheme/style.css" rel="stylesheet" media="all" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_top_menu" Runat="Server">
    <asp:Menu ID="MenuSub" runat="server" Orientation="Horizontal" BorderStyle="Double" CssClass="Menu" OnMenuItemClick="MenuSub_MenuItemClick">
            <Items>
                <asp:MenuItem Text="All Time" Value="All Time"></asp:MenuItem>
                <asp:MenuItem Text="Today" Value="Today"></asp:MenuItem>
                <asp:MenuItem Text="Yesterday" Value="Yesterday"></asp:MenuItem>
                <asp:MenuItem Text="More..." Value="More..."></asp:MenuItem>
            </Items>
        </asp:Menu>
    <asp:DropDownList ID="DropDownList1" style="color:White;background-color:#525461;border-radius: 0px 0px 10px 5px;" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
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
    <div class="clearfix colelem" id="marginuplist"><!-- group -->
     <div class="clearfix grpelem" id="pu756"><!-- column -->
        <%-- <asp:ScriptManager EnablePartialRendering="true"
 ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
 
     
      <div class="clearfix colelem" id="u756"><!-- group -->
       <div class="museBGSize grpelem" id="u757">
            <asp:Image ID="ImageProfile" runat="server" Width="130px" Height="116px" /> </div>
      <div class="shadow clearfix grpelem" id="post_item" style="left:10px"><!-- group -->
          <div style="float:left;">
          <asp:TextBox ID="txtPostTitle" runat="server"></asp:TextBox>
          </div>
         <div style="float:right;margin-bottom:10px">
             <asp:ImageButton ID="ImageButton12" runat="server" ImageUrl="~/images/icon/gray/tag.png" Width="20" Height="20" />
                 <asp:ImageButton ID="ImageButton13" runat="server" ImageUrl="~/images/icon/gray/location.png" Width="20" />
           
                 <a onclick="clk();"> <img src="images/icon/gray/attach.png" width="20"/></a>
                 
<%--                 <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/icon/black/attach.png" Width="20" OnClientClick=" clk();" />--%>
                 <asp:ImageButton ID="ImageButton14" runat="server" ImageUrl="~/images/icon/gray/emoticon.png" Width="20" Visible="false" />
             </div>
      <asp:TextBox ID="txtNewPost" runat="server" Columns="40" Rows="2" style="overflow:hidden" onkeyup="setHeight(this)" TextMode="MultiLine" Width="405px" EnableViewState="False"></asp:TextBox>
         <div style="float:left; display:inline;">
           Post By:<asp:TextBox ID="txtPostedby" runat="server" style="border-width:1px;border-style:solid;width:150px;background-color: rgb(69, 81, 94);color: white;text-align: center;" 

ReadOnly="true">anonymous</asp:TextBox>
            <%--<asp:Label ID="txtPostedby" runat="server" ></asp:Label>--%>
            <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True">
                <asp:ListItem>Romantic</asp:ListItem>
                <asp:ListItem>Religious</asp:ListItem>
                <asp:ListItem>Patriotic</asp:ListItem>
                <asp:ListItem>Educational</asp:ListItem>
                <asp:ListItem>Experience</asp:ListItem>
                <asp:ListItem>Travel</asp:ListItem>
                <asp:ListItem>Review</asp:ListItem>
            </asp:DropDownList>
          <%--   <asp:FileUpload ID="FileUpload1" runat="server" Width="100px" />--%>
            <%--<asp:Button ID="btnNewPost" runat="server" Text="Post" OnClick="btnNewPost_Click" Width="50px" 

EnableViewState="False" />--%>

        </div>
         
             <div style="float:right; display:inline;margin-top:10px">
            
                      <asp:ImageButton ID="btnNewPost" runat="server" Text="Post" ImageUrl="~/images/icon/gray/post.png" Width="20" OnClick="btnNewPost_Click" EnableViewState="False"  />
                   <ajaxToolkit:AnimationExtender ID="ae" runat="server" TargetControlID="btnNewPost">
                              <Animations>
 <OnClick>
 <Sequence>
 <EnableAction Enabled="false" />
 <Parallel>
 <FadeOut Duration="1.5" Fps="24" AnimationTarget="UpdatePanel1" />
     <FadeIn Duration="1.5" Fps="24" AnimationTarget="UpdatePanel1" />
    
 
 </Parallel>
      <EnableAction Enabled="true" />
 </Sequence>
 </OnClick>
 </Animations> </ajaxToolkit:AnimationExtender>
            
        </div>

        
                  <div style="float:right; display:none;"><asp:FileUpload ID="FileUpload1" runat="server" /></div>
     </div>
       
      </div>
         <div style="float:left; display:inline; position:relative; width: 130px; height:35px;margin-top:15px;top:-40px">
            <%-- <asp:Panel ID="Panel1" runat="server" Visible="false">
                 <div>
        Choose Your Name:<asp:TextBox ID="TextBox1" runat="server" Width="214px"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="OK" OnClientClick="f2();" />
    </div>
             </asp:Panel>--%>
             <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/logo_covert.png" Width="40px" Height="35px" OnClick="ImageButton1_Click" />
             <asp:ImageButton ID="ImageButton2" runat="server" Width="40px" Height="35px" OnClick="ImageButton2_Click" />
          <%--   <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/avatar-female.png" Width="40px" Height="35px" OnClick="ImageButton3_Click" OnClientClick="return popitup('covert_avatar.aspx')"/>--%>
             <asp:ImageButton ID="ImageButton4" OnClientClick="$('html').css('overflow', 'hidden');" runat="server" ImageUrl="~/images/avatars/avatar-female.png" Width="40px" Height="35px" />
             <div>
        <asp:Panel ID="pnModelPopup" runat="server" CssClass="popup" ScrollBars="Auto" Style="display:none;">
         
                Choose Your Avatar:<br />
               <%-- <asp:Repeater ID="RepeaterImages" runat="server" OnItemCommand="RepeaterImages_ItemCommand" OnItemCreated="RepeaterImages_ItemCreated">
    <ItemTemplate>
        <asp:ImageButton ID="Image" Width="100" Height="100" runat="server" ImageUrl='<%# Container.DataItem %>' />
    </ItemTemplate>
</asp:Repeater>--%>
            <br />
             <asp:ImageButton ID="Image" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar1.jpg" OnClick="Image_Click1"/>
            <asp:ImageButton ID="ImageButton3" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar2.jpg" OnClick="Image_Click1"/>
            <asp:ImageButton ID="ImageButton5" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar3.jpg" OnClick="Image_Click1"/><br />
            <asp:ImageButton ID="ImageButton6" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar4.jpg" OnClick="Image_Click1"/>
            <asp:ImageButton ID="ImageButton7" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar5.jpg" OnClick="Image_Click1"/>
            <asp:ImageButton ID="ImageButton8" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar6.jpg" OnClick="Image_Click1"/><br />
            <asp:ImageButton ID="ImageButton9" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar7.jpg" OnClick="Image_Click1"/>
            <asp:ImageButton ID="ImageButton10" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar8.jpg" OnClick="Image_Click1"/>
            <asp:ImageButton ID="ImageButton11" Width="100" Height="100" runat="server" ImageUrl="~/images/avatars/avatar9.jpg" OnClick="Image_Click1"/><br />
          
                 Choose Your Name:<asp:TextBox ID="TextBox1" runat="server" Width="214px"></asp:TextBox><br />
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="OK" />
             
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                  
        </asp:Panel>
        <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');"  ID="ModalPopupExtender1" runat="server" PopupControlID="pnModelPopup" TargetControlID="ImageButton4"                                      
             DropShadow="true" BackgroundCssClass="modalBackground"
            CancelControlID="btnCancel" Drag="false">
        </ajaxToolkit:ModalPopupExtender>
        <%--<div style="margin-left: 300px">
            <asp:LinkButton ID="lnkbtnSignin" runat="server">Sign in</asp:LinkButton>
        </div>--%>
    </div>
                 
        
         </div>
      <div class="clearfix colelem" id="post_section_full_list"><!-- group -->
       <div class="clearfix grpelem" id="u872"><!-- column -->
             <div>
 <asp:UpdatePanel ID="UpdatePanel1" runat="server"
 UpdateMode="Always">
 <ContentTemplate>

        <asp:ListView ID="ListView1" runat="server" DataSourceID="CovertDataSource" DataKeyNames="CovertId,LikeId,UserId" GroupItemCount="1" OnItemCreated="ListView1_ItemCreated" OnItemDataBound="ListView1_ItemDataBound" OnItemCommand="ListView1_ItemCommand">
           
            <EditItemTemplate>
                <td runat="server"><%--CovertId:
                    <asp:TextBox ID="CovertIdTextBox" runat="server" Text='<%# Bind("CovertId") %>' />--%>
                   
                    
                   <%-- <br />CovertPostDate:
                    <asp:TextBox ID="CovertPostDateTextBox" runat="server" Text='<%# Bind("CovertPostDate") %>' />
                    <br />CovertPostUser:
                    <asp:TextBox ID="CovertPostUserTextBox" runat="server" Text='<%# Bind("CovertPostUser") %>' />
                    <br />--%>
                   

                    <asp:Panel id="post_backcolor" runat="server" class="colelem post_section_full_list">
                   <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>' OnInit="CovertIdLabel_Init" Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                         <%--<asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' Visible="false" />--%>
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo">
                          <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "AvatarHandler.ashx?covertid=" + Eval("CovertId") %>' />


            </div>

               <div class="post_top_info">
               <div style="float:right;margin-right:-10px;">
                           <asp:ImageButton ID="EditButton" ImageUrl="~/images/icon/gray/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" ImageUrl="~/images/icon/gray/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                       </div>
                   <asp:Label ID="CovertPostUserLabel" runat="server" Text='<%# Eval("CovertPostUser") %>' />
                   <br />
              
                   <asp:Label ID="CovertPostDateLabel" runat="server" Text='<%# Eval("CovertPostDate") %>' />
                   <br />
                         </div>
                <div class="post_media_section" style="
    height: 500px;
">
                   
                <embed id='embed1' autostart='false' runat="server" name='mediaPlayer' type='application/x-mplayer2' pluginspage='http://microsoft.com/windows/mediaplayer/en/download/'  displaysize='4' autosize='-1' bgcolor='darkblue' showcontrols='true' showtracker='-1' showdisplay='0' showstatusbar='-1' videoborder3d='-1' width='573' height='500'  designtimesp='5311' loop='false' src='<%# "ThumbnailHandlerCovertMedia.ashx?covertid=" + Eval("CovertId") %>' visible="false"/>
                
                    </div>
                   
            <div class="colelem post_section" style="width: 573px;">
                   <asp:TextBox ID="CovertPostTextBox" runat="server" Text='<%# Bind("CovertPost") %>' BorderWidth="1" BorderStyle="Solid" BorderColor="Black" onkeyup="setHeight(this)" Width="573" TextMode="MultiLine" />
                   <br /></div>
               <div style="margin:10px;">
                <asp:Button ID="UpdateButton" runat="server" CommandName="Updatepost" Text="Update" />
                    
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                    </div>
           </div>
                      <div class="colelem like_dislike_share_section">
                      <asp:ImageButton ID="LinkButtonLike" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/gray/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                            <br />
                            <asp:LinkButton ID="LinkViewAllComment" runat="server" Visible="false">View all comments</asp:LinkButton>
                           </div>

          </asp:Panel>
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
            <InsertItemTemplate>
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
            </InsertItemTemplate>
            <ItemTemplate>
               
                <td runat="server" id="tdPwd"  >
                     <%--CovertId:<asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>' Visible="true" />--%>
                
                      <asp:Panel id="post_backcolor" runat="server" class="colelem post_section_full_list">
                   <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>' OnInit="CovertIdLabel_Init" Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                         <%--<asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' Visible="false" />--%>
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo">
                          <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "AvatarHandler.ashx?covertid=" + Eval("CovertId") %>' />


            </div>

               <div class="post_top_info">
               <div style="float:right;margin-right:-10px;">
                           <asp:ImageButton ID="EditButton" ImageUrl="~/images/icon/gray/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" ImageUrl="~/images/icon/gray/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                       </div>
                   <asp:Label ID="CovertPostUserLabel" runat="server" Text='<%# Eval("CovertPostUser") %>' />
                   <br />
              
                   <asp:Label ID="CovertPostDateLabel" runat="server" Text='<%# Eval("CovertPostDate") %>' />
                   <br />
                         </div>
                <div class="post_media_section" style="
    height: 500px;
">
                   
                <embed id='embed1' autostart='false' runat="server" name='mediaPlayer' type='application/x-mplayer2' pluginspage='http://microsoft.com/windows/mediaplayer/en/download/'  displaysize='4' autosize='-1' bgcolor='darkblue' showcontrols='true' showtracker='-1' showdisplay='0' showstatusbar='-1' videoborder3d='-1' width='573' height='500'  designtimesp='5311' loop='false' src='<%# "ThumbnailHandlerCovertMedia.ashx?covertid=" + Eval("CovertId") %>' visible="false"/>
                
                    </div>
                   
            <div class="colelem post_section" style="width: 573px;">
                 Title: <asp:Label ID="Label1" runat="server" Text='<%# Eval("PostTitle") %>' /><br />
                   <asp:Literal ID="CovertPostLabel" runat="server" Text='<%# AddEmotes( Eval("CovertPost").ToString()) %>' />
                   <br /></div>
               
           </div>
                      <div class="colelem like_dislike_share_section">
                      <asp:ImageButton ID="LinkButtonLike" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/gray/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                            <br />
                            <asp:LinkButton ID="LinkViewAllComment" runat="server" Visible="false">View all comments</asp:LinkButton>
                           </div>

          </asp:Panel>
                       
                    
                    <asp:ListView ID="ListView2" runat="server" DataKeyNames="CommentId,LikeId" DataSourceID="CovertCommentDataSource" InsertItemPosition="LastItem" OnItemInserting="ListView2_ItemInserting" OnItemCreated="ListView2_ItemCreated" OnItemCommand="ListView2_ItemCommand">
           
             <EditItemTemplate>
                 <span style="">CommentId:
                 <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                 <br />
                 Comment:
                 <asp:TextBox ID="CommentTextBox" runat="server" Text='<%# Bind("Comment") %>' />
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
                   <div class="colelem comment_new_full" style="margin-bottom:0px;width:593px;">
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
                    

                        </div>
                <div class="comment_new_section">
                
<asp:TextBox ID="CommentTextBox" onkeyup="setHeight(this)" runat="server" Text='<%# Bind("Comment") %>' Width="500"  /> 
                  <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Comment" />
                </div>
              
                
               <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                </div>
                </span>
                      </asp:panel>
             </InsertItemTemplate>
             <ItemTemplate>
                  
                  <span style="">
                     <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                    <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>' Visible="false" />

                  
                 <div class="colelem comment_post_full" style="width: 593px;">
                     <div class="position_content" >
           <div class=" grpelem comment_post_profile_photo">
                <asp:ImageButton ID="ImageProfile2" runat="server" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">
                <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' /><br />
                <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                        
                     <div class="colelem comment_post_section" style="width: 573px;">
                   <asp:Literal ID="CommentLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="colelem comment_post_like_section">
              <asp:ImageButton ID="LinkButtonLike" runat="server" CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/gray/thumbs_like.png" ></asp:ImageButton>
                       <%--<asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                            
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
            <SelectedItemTemplate>
                <td runat="server" style="background-color: #E2DED6;font-weight: bold;color: #333333;">CovertId:
                    <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>' />
                    <br />CovertPost:
                    <asp:Label ID="CovertPostLabel" runat="server" Text='<%# Eval("CovertPost") %>' />
                    <br />CovertPostDate:
                    <asp:Label ID="CovertPostDateLabel" runat="server" Text='<%# Eval("CovertPostDate") %>' />
                    <br />CovertPostUser:
                    <asp:Label ID="CovertPostUserLabel" runat="server" Text='<%# Eval("CovertPostUser") %>' />
                    <br /></td>
            </SelectedItemTemplate>
            
           </asp:ListView>
           
           <asp:SqlDataSource ID="CovertDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="CovertDataSource_Selecting" SelectCommand="SELECT * FROM [CovertPosts] WHERE DATEADD(dd, 0, DATEDIFF(dd, 0, CovertPostDate)) = @CovertPostDate;">
               <SelectParameters>
                   <asp:Parameter Name="CovertPostDate" Type="DateTime" />
               </SelectParameters>
        </asp:SqlDataSource>
      <asp:SqlDataSource ID="CovertCommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [CovertComments] WHERE ([CovertId] = @CovertId) ORDER BY [CommentDate]" OnSelecting="CovertCommentDataSource_Selecting">
             <SelectParameters>
                 <asp:Parameter Name="CovertId" Type="Object" />
             </SelectParameters>
         </asp:SqlDataSource>
          
           </ContentTemplate>

 </asp:UpdatePanel>
     </div>


             </div>
       
      </div>
         
         

</div>
     
               
     <div class="clearfix grpelem" id="divider_right_covert" style="margin-left: 605px;margin-top: -65px;"><!-- group -->
         <div id="listgrid_bar" style="width: 135px;	margin-left: 5px; margin-top: -95px;	position: relative;    float:left;">
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
      <div class="clearfix grpelem" id="side_menu_list" style="
    margin-top: 45px;
"><!-- column -->
       
           <asp:Button ID="btnRomantic" runat="server" Text="Romantic" CssClass="sidecatmenu" OnClick="btnRomantic_Click" />
          <asp:Button ID="btnReligious" runat="server" Text="Religious" CssClass="sidecatmenu" OnClick="btnReligious_Click" />
          <asp:Button ID="btnPatriotic" runat="server" Text="Patriotic" CssClass="sidecatmenu" OnClick="btnPatriotic_Click" />
          <asp:Button ID="btnEducational" runat="server" Text="Educational" CssClass="sidecatmenu" OnClick="btnEducational_Click" />
          <asp:Button ID="btnExperience" runat="server" Text="Experience" CssClass="sidecatmenu" OnClick="btnExperience_Click" />
          <asp:Button ID="btnTravel" runat="server" Text="Travel" CssClass="sidecatmenu" OnClick="btnTravel_Click" />
          <asp:Button ID="btnReview" runat="server" Text="Review" CssClass="sidecatmenu" OnClick="btnReview_Click" />
       
      </div>
     
     </div>
    </div>
</asp:Content>

