<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="NotificationCovert.aspx.cs" Inherits="Default4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        #top_menu{
            display:none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_top_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_left_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" style="
    margin-top: 60px;
"
 UpdateMode="Always">
 <ContentTemplate>

        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="CovertId,LikeId,UserId" GroupItemCount="1" OnItemCreated="ListView1_ItemCreated" OnItemDataBound="ListView1_ItemDataBound" OnItemCommand="ListView1_ItemCommand">
           
            <EditItemTemplate>
                <td runat="server"><%--CovertId:
                    <asp:TextBox ID="CovertIdTextBox" runat="server" Text='<%# Bind("CovertId") %>' />--%>
                   
                    
                   <%-- <br />CovertPostDate:
                    <asp:TextBox ID="CovertPostDateTextBox" runat="server" Text='<%# Bind("CovertPostDate") %>' />
                    <br />CovertPostUser:
                    <asp:TextBox ID="CovertPostUserTextBox" runat="server" Text='<%# Bind("CovertPostUser") %>' />
                    <br />--%>
                   

                    <asp:Panel id="post_backcolor" runat="server" class="colelem post_section_full_list" style="
    width: 970px;
">
                   <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>'  Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                         <%--<asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' Visible="false" />--%>
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo" style="
    margin-top: 0px;
">
                          <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "AvatarHandler.ashx?covertid=" + Eval("CovertId") %>' />


            </div>

               <div class="post_top_info">
               <div class="post_edit_delete" style="margin-top: -5px;margin-right: -5px;">
                           <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                       </div>
                   <asp:Label ID="CovertPostUserLabel" runat="server" Text='<%# Eval("CovertPostUser") %>' />
                   <br />
              
                   <asp:Label ID="CovertPostDateLabel" runat="server" Text='<%# Eval("CovertPostDate") %>' />
                   <br />
                         </div>
                <div class="post_media_section">
                   
                <video id="embed1" src='<%# "ThumbnailHandlerPostMedia.ashx?postid=" + Eval("CovertId") %>' width="534" height="300" style="
    margin-top: 0px;
    margin-left: 20px;
"></video>
                
                    </div>
                   
            <div class="colelem post_section_list" style="width: 935px;">
                   <asp:TextBox ID="CovertPostTextBox" runat="server" Text='<%# Bind("CovertPost") %>' BorderWidth="1" BorderStyle="Solid" BorderColor="Black" onkeyup="setHeight(this)" Width="573" TextMode="MultiLine" />
                   <br /></div>
               <div style="margin:10px;">
                <asp:Button ID="UpdateButton" runat="server" CommandName="Updatepost" Text="Update" />
                    
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                    </div>
           </div>
                      <div class="colelem like_dislike_share_section_list">
                      <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                            <br />
                           <asp:Button ID="LinkViewAllComment" runat="server" Visible="true" Text="View all comments" style="border-width: 1px;width: 950px;background-color: #535461;color: white; border-radius: 5px;" CommandName="allcomment"></asp:Button>
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
               
                <td id="tdPwd"  >
                      <asp:Panel runat="server" id="items" >
                     <%--CovertId:<asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>' Visible="true" />--%>
                
                      <asp:Panel id="post_backcolor" runat="server" class="colelem post_section_full_list" style="
    width: 970px;
">
                   <asp:Label ID="CovertIdLabel" runat="server" Text='<%# Eval("CovertId") %>'  Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                         <%--<asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' Visible="false" />--%>
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo" style="
    margin-top: 0px;
">
                          <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "AvatarHandler.ashx?covertid=" + Eval("CovertId") %>' />


            </div>

               <div class="post_top_info">
               <div class="post_edit_delete" style="margin-top: -5px;margin-right: -5px;">
              <asp:ImageButton ID="BookmarkButton" CssClass="icon" ImageUrl="~/images/icon/black/bookmark.png" style="width: 15px;margin-right: 5px;" runat="server" CommandName="Bookmarkpost" AlternateText="Bookmark" />

              <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" AlternateText="Edit" />
              <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" AlternateText="Delete" />
                   <ajaxToolkit:AnimationExtender ID="AnimationExtender3" runat="server" TargetControlID="DeleteButton">
            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="items" Duration="1" Fps="30">
                <FadeOut AnimationTarget="items" Fps="30" />
                
            </Parallel>
           
           </OnClick>
            </Animations>
        </ajaxToolkit:AnimationExtender>
              
                  

                       </div>
                    <asp:Label ID="CovertPostUserName" runat="server" Text='<%# Eval("CovertPostUserName") %>' Visible="false" />
                   <asp:HyperLink ID="CovertPostUserLabel" runat="server" Text='<%# Eval("CovertPostUser") %>' />
                   <br />
              
                   <asp:Label ID="CovertPostDateLabel" runat="server" Text='<%# Eval("CovertPostDate") %>' />
                   <br />
                         </div>
                <div class="post_media_section">
                   <asp:Panel runat="server" Visible="false" ID="pnlVideo">
                <video runat="server" id="videoplayer" style="width: 570px;" controls="controls" src='<%# "VideoHandlerCovert.ashx?covertid=" + Eval("CovertId") %>' width="534" height="300"></video>
                       </asp:Panel>                   
                         <asp:ImageButton ID="imgbtn" runat="server" ImageUrl='<%# "ThumbnailHandlerCovertMedia.ashx?covertid=" + Eval("CovertId") %>' Visible="false" style="
    margin-left: 125px;
" />
                        <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'hidden');" ID="MPEPopImage" CancelControlID="btnClose"  DropShadow="true"  BackgroundCssClass="modalBackgroundImage" Drag="false" runat="server" TargetControlID="imgbtn" PopupControlID="Panel1"></ajaxToolkit:ModalPopupExtender>
               
                           <asp:Panel ID="Panel1" runat="server" style="margin-top: 50px;z-index: 10000;display:none; height: 500px; opacity: 1; box-shadow: rgb(0, 0, 0) 5px 5px 5px; background-color: white;">
                             <div style="float:left">
              <asp:Image Width="700" Height="500" ID="ImageButton2" runat="server" ImageUrl='<%# "CovertHandler.ashx?covertid=" + Eval("CovertId") %>' />

                             </div>
                            <div style="float:right;margin:20px;">
                                 <asp:Button ID="btnClose" runat="server" Text="X" style="margin-left: -735px;display: block;clear: both;width: 30px;height: 30px;border-radius: 300px;margin-top: -34px;border: 6px solid rgb(242, 243, 244);background: rgb(204, 222, 232);color: rgb(10, 22, 45);font-weight: bold;margin-top: -38px;" />
                           <asp:ImageButton ID="Image2" runat="server" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' Style="vertical-align:top" />
<%--                                            <asp:HyperLink ID="FullNameLabel" runat="server" Text='<%# Eval("FirstName") %>' NavigateUrl='<%# Eval("UserId","~/profile-list_search.aspx?userid={0}") %>' />--%>
                                                      <asp:HyperLink ID="HyperLink2" runat="server" Text='<%# Eval("CovertPostUser") %>' NavigateUrl='<%# Eval("CovertPostUserName","~/index_m.aspx?un={0}") %>' /> 
<br />
                       
                                <asp:Label ID="DateCreatedLabel" runat="server" style="display: block;margin-left: 56px;margin-top: -16px;" Text='<%# Eval("CovertPostDate") %>' /><br />
                                <asp:Label ID="Label2" runat="server" style="margin-bottom: 20px;display: block;margin-top: 5px;" Text='<%# Eval("CovertPost") %>' /><br />
                              
                               <asp:ListView ID="ListView3" runat="server" DataKeyNames="CommentId,LikeId" DataSourceID="CovertCommentDataSource" InsertItemPosition="LastItem" OnItemInserting="ListView2_ItemInserting" OnItemCreated="ListView2_ItemCreated" OnItemCommand="ListView2_ItemCommand">
           
             <EditItemTemplate>
                 <span style="">CommentId:
                 <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                 <br />
                 Comment:
                 <asp:TextBox ID="CommentTextBox" class='animated' TextMode="MultiLine" style="width:490px" runat="server" Text='<%# Bind("Comment") %>' />
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
                   <div class="colelem comment_new_full" style="margin-top:-7px;width:970px;">
                        <div class=" grpelem comment_new_profile_photo" style="
    margin-top: 0px;
">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
                    

                        </div>
                <div class="comment_new_section">
                
<asp:TextBox ID="CommentTextBox" class='animated' placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" runat="server" Text='<%# Bind("Comment") %>' style="width:880px;height: 50px;"/> 
                  <asp:Button ID="InsertButton" runat="server" style="margin-left: 885px;height: 30px;width: 70px;background-color: #26284f;color: white;margin-bottom: 10px;" CommandName="Insert" Text="Comment" />
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

                  
                 <div class="colelem comment_post_full" style="width: 970px;">
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
                        
                     <div class="colelem comment_post_section" style="width: 573px;">
                   <asp:Literal ID="CommentLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="colelem comment_post_like_section">
              <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                       <%--<asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                     <hr style="
    display: block;
    margin-top: 85px;
" />
                            
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

                
                    </div>
                   
            <div class="colelem post_section_list" style="width: 935px;">
                 Title: <asp:Label ID="Label1" runat="server" Text='<%# Eval("PostTitle") %>' /><br />
                   <asp:Literal ID="CovertPostLabel" runat="server" Text='<%# AddEmotes( Eval("CovertPost").ToString()) %>' />
                   <br /></div>
               
           </div>
                      <div class="colelem like_dislike_share_section_list">
                      <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                            <br />
                           <asp:Button ID="LinkViewAllComment" runat="server" Visible="true" Text="View all comments" style="border-width: 1px;width: 950px;background-color: #535461;color: white; border-radius: 5px;" CommandName="allcomment"></asp:Button>
                       <ajaxToolkit:AnimationExtender ID="AnimationExtender1" runat="server" TargetControlID="LinkViewAllComment">
            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="PanelComment" Duration="3" Fps="25">
                <FadeOut AnimationTarget="PanelComment" minimumOpacity=".1" Fps="30" />
                <FadeIn AnimationTarget="PanelComment" minimumOpacity=".1" Fps="30" />  
            </Parallel>
           
           </OnClick>
            </Animations>
        </ajaxToolkit:AnimationExtender>     
                      </div>

          </asp:Panel>
                       
                    <asp:Panel ID="PanelComment" runat="server">
                    <asp:ListView ID="ListView2" runat="server" DataKeyNames="CommentId,LikeId" DataSourceID="CovertCommentDataSource" InsertItemPosition="LastItem" OnItemInserting="ListView2_ItemInserting" OnItemCreated="ListView2_ItemCreated" OnItemCommand="ListView2_ItemCommand">
           
             <EditItemTemplate>
                 <span style="">CommentId:
                 <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                 <br />
                 Comment:
                 <asp:TextBox ID="CommentTextBox" class='animated' TextMode="MultiLine" style="width:490px" runat="server" Text='<%# Bind("Comment") %>' />
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
                   <div class="colelem comment_new_full" style="margin-top:-7px;width:970px;">
                        <div class=" grpelem comment_new_profile_photo" style="
    margin-top: 0px;
">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
                    

                        </div>
                <div class="comment_new_section">
                
<asp:TextBox ID="CommentTextBox" class='animated' placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" runat="server" Text='<%# Bind("Comment") %>' style="width:880px;height: 50px;"/> 
                  <asp:Button ID="InsertButton" runat="server" style="margin-left: 885px;height: 30px;width: 70px;background-color: #26284f;color: white;margin-bottom: 10px;" CommandName="Insert" Text="Comment" />
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

                  
                 <div class="colelem comment_post_full" style="width: 970px;">
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
                        
                     <div class="colelem comment_post_section" style="width: 573px;">
                   <asp:Literal ID="CommentLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="colelem comment_post_like_section">
              <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                       <%--<asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                     <hr style="
    display: block;
    margin-top: 85px;
" />
                            
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
                            <table id="groupPlaceholderContainer" runat="server" border="1" style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;margin-top: -5px;">
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

     <div style="width: 600px ;  margin-left: auto ;  margin-right: auto ;position:relative;top:15px">
     <div id="divImage" style="display:none" >
      <div class="spinner">
  <div class="bounce1"></div>
  <div class="bounce2"></div>
  <div class="bounce3"></div>
</div>
     </div>
                  </div>
           
           <asp:SqlDataSource ID="CovertDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="CovertDataSource_Selecting" SelectCommand="SELECT * FROM [CovertPosts] ORDER BY [CovertPostDate] DESC"></asp:SqlDataSource>
      <asp:SqlDataSource ID="CovertCommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT top 2 * FROM [CovertComments] WHERE ([CovertId] = @CovertId) ORDER BY [CommentDate]" OnSelecting="CovertCommentDataSource_Selecting">
             <SelectParameters>
                 <asp:Parameter Name="CovertId" Type="Object" />
             </SelectParameters>
         </asp:SqlDataSource>
          
           </ContentTemplate>
     
 </asp:UpdatePanel>
    

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" OnSelecting="SqlDataSource1_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [CovertPosts] WHERE ([CovertId] = @CovertId)">
        <SelectParameters>
            <asp:Parameter Name="CovertId" Type="Object" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

