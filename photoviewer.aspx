<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="photoviewer.aspx.cs" Inherits="Default4" %>

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
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" style="margin-top: 20px;margin-left: 110px;" UpdateMode="Always">
 <ContentTemplate>

   <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID,LikeId,PhotoID,CommentId" DataSourceID="SqlDataSource1"  OnItemCreated="ListView1_ItemCreated" OnItemCommand="ListView1_ItemCommand">
               
               <EditItemTemplate>
                   <span style="">
                   <%--<asp:HyperLink ID="HyperLink2" runat="server" Text='<%# Eval("PostUser") %>' NavigateUrl='<%# Eval("UserId","~/profile-list_search.aspx?userid={0}") %>' />--%>
                  
                       <div class="colelem post_section_full_edit"><!-- post section -->
                  
                       <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                           <asp:Label ID="Label1" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                           
                       
           <div class="position_content" style="margin-top: -15px;">
            <div class=" colelem post_profile_photo" style="margin-top: -11px;">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />

            </div>

               <div class="post_top_info" style="
    margin-top: 45px;
">
               
               <%--    <asp:HyperLink ID="PostUserLabel" runat="server" Text='<%# Eval("PostUser") %>' NavigateUrl="" />--%>
                               <asp:HyperLink ID="PostUserLabel" runat="server" Text='<%# Eval("PostUser") %>' NavigateUrl='<%# Eval("PostUserName","~/index_m.aspx?un={0}") %>' /> 

                   <br />
              
                   <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("PostDate") %>' />
                   <br />
                         </div>
                   
            <div class="colelem post_section" style="margin-top: -25px;padding: 5px; width: 720px;">
                    <asp:TextBox ID="PostTextBox" class='animated' runat="server" TextMode="MultiLine" Text='<%# Bind("Post") %>' onkeyup="setHeight(this)" Width="236" />
                   <br />
                
            </div>
               <div style="margin-left:10px;">
               <asp:Button ID="UpdateButton" runat="server" CommandName="Updatepost" Text="Update" />
                   <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel"/>
                   </div>
           </div>
                      <div class="colelem like_dislike_share_section" style="margin-top: 15px;">
                       <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server">Comment</asp:LinkButton>--%>
                                                    <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                       <asp:ImageButton ID="ImageButtonShare" CssClass="icon" runat="server" CommandName="SharePostId" Width="20" ImageUrl="~/images/icon/black/share3.png" ></asp:ImageButton>

                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            
                           
                           <asp:Button ID="LinkViewAllComment" runat="server" Visible="true" Text="View all comments"  CommandName="allcomment"></asp:Button>
                       
                          
                           </div>
 
                            </div>
                  
                   </span>
               </EditItemTemplate>
               <EmptyDataTemplate>
                   <span>No posts found.</span>
               </EmptyDataTemplate>
               <InsertItemTemplate>
                   <span style="">PostId:
                   <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PostId") %>' />
                   <br />Post:
                   <asp:TextBox ID="PostTextBox" runat="server" Text='<%# Bind("Post") %>' />
                   <br />PostDate:
                   <asp:TextBox ID="PostDateTextBox" runat="server" Text='<%# Bind("PostDate") %>' />
                   <br />UserId:
                   <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                   <br />PostContent:
                   <asp:TextBox ID="PostContentTextBox" runat="server" Text='<%# Bind("PostContent") %>' />
                   <br />PostContentType:
                   <asp:TextBox ID="PostContentTypeTextBox" runat="server" Text='<%# Bind("PostContentType") %>' />
                   <br />PostUser:
                   <asp:TextBox ID="PostUserTextBox" runat="server" Text='<%# Bind("PostUser") %>' />
                   <br />
                   <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                   <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                   <br /><br /></span>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Panel runat="server" id="items" >
                   <span>
                       <div class="colelem post_section_full_grid" style="width: 750px;"><!-- post section -->
                  
                       <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                           <asp:Label ID="PhotoIDLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                           
                           <div class="post_edit_delete" style="margin: 7px;">
                           <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                               <ajaxToolkit:ConfirmButtonExtender ID="cbe" runat="server"
    TargetControlID="DeleteButton"
     DisplayModalPopupID="ModalPopupExtender1"
     />
   <ajaxToolkit:ModalPopupExtender TargetControlID="DeleteButton" BackgroundCssClass="modalBackground" ID="ModalPopupExtender1" runat="server" OkControlID="ok" CancelControlID="cancel" PopupControlID="Panel1">
      
   </ajaxToolkit:ModalPopupExtender>
                               <asp:Panel ID="Panel1" runat="server" CssClass="popup"  Style="display:none;padding:20px; border-radius:5px;z-index:1000000000000 !important">
                                    <asp:Label runat="server" Text="Are you sure you want to delete this post?"></asp:Label>
       <asp:Button runat="server" Text="OK" ID="ok" />
       <asp:Button runat="server" Text="Cancel" ID="cancel" /> 
                               </asp:Panel>
                               <%-- <ajaxToolkit:AnimationExtender ID="AnimationExtender2" runat="server" TargetControlID="DeleteButton">
            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="items" Duration=".3" Fps="30">
                <FadeOut AnimationTarget="items" Fps="30" />
                
            </Parallel>
           
           </OnClick>
            </Animations>
        </ajaxToolkit:AnimationExtender>--%>
                               <asp:HiddenField ID="HiddenField1" runat="server" />
                               
                       </div>
           <div class="position_content" style="margin-top: -15px;">
            <div class=" colelem post_profile_photo" style="margin-top: -23px;">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />

            </div>

               <div class="post_top_info" style="margin-top: 45px;">

                   <asp:HyperLink ID="PostUserLabel" runat="server" Text='<%# Eval("UserName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' />
                   <br />
              
                   <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                   <br />
                         </div>
                   
            <div class="colelem post_section" style="margin-top: -25px;padding: 5px; width: 720px;">
                  <%-- <asp:Label ID="PostLabel" runat="server" Text='<%# Eval("Post") %>' />--%>
                                           <asp:Image style="height:auto;width:720px;margin-right: 12px;margin-bottom: 8px;" ID="ImageButton1" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' CommandName="popimage" CommandArgument='<%# Eval("PhotoID") %>' />

                  <asp:Literal ID="literalPost" runat="server" Text='<%# AddEmotes( Eval("Description").ToString()) %>' />
                   <br /></div>
               
           </div>
                      <div class="like_dislike_share_section" style="margin-top: 15px;">
                       <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server">Comment</asp:LinkButton>--%>
                                                    <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                       <asp:ImageButton ID="ImageButtonShare" CssClass="icon" runat="server" CommandName="SharePostId" Width="20" ImageUrl="~/images/icon/black/share3.png" ></asp:ImageButton>

                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            
                            <br />
                            <asp:Button ID="LinkViewAllComment" runat="server" Visible="true" Text="View all comments" style="border-width: 1px;width: 730px;background-color: #535461;color: white; border-radius: 5px;" CommandName="allcomment"></asp:Button>
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
                           <div class="spinnercm" style="display:none">
  <div class="bounce1"></div>
  <div class="bounce2"></div>
  <div class="bounce3"></div>
</div>
                         
                          
                           </div>

          
                       
                            </div>
                      <asp:Panel ID="PanelPostComment" runat="server">
<asp:ListView ID="ListViewPostComment"  runat="server" DataKeyNames="CommentId,PhotoID,CommentUser,CommentUserId" DataSourceID="PostCommentDataSource" InsertItemPosition="LastItem" OnItemInserting="ListViewPostComment_ItemInserting" OnItemCreated="ListViewPostComment_ItemCreated" OnItemCommand="ListViewPostComment_ItemCommand">
                
                <EditItemTemplate>
                    <span style="">CommentId:
                    <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                    <br />
                    Comment:
                    <asp:TextBox ID="CommentTextBox" class='animated' style="width:200px"   TextMode="MultiLine" runat="server" Text='<%# Bind("Comment") %>' />
                    <br />
                    CommentUser:
                    <asp:TextBox ID="CommentUserTextBox" runat="server" Text='<%# Bind("CommentUser") %>' />
                    <br />
                    CommentDate:
                    <asp:TextBox ID="CommentDateTextBox" runat="server" Text='<%# Bind("CommentDate") %>' />
                    <br />
                    PostId:
                    <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PostId") %>' />
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                    <br /><br /></span>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <span>No Comment found.</span>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <asp:panel defaultbutton="InsertButton" runat="server">
                    <span style="">
                        <%--<div class="_u608 f3s_top" id="_u608-f3s_top"></div>--%>
                     <div class="colelem comment_new_full" style="
    margin-bottom: 15px;
    width: 750px;
">
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
           

                    </div>
                <div class="comment_new_section" style="">
                <asp:TextBox ID="CommentTextBox" class='animated' Rows="1"  runat="server" TextMode="MultiLine" Text='<%# Bind("Comment") %>' style="width:670px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Comment" style="margin-left: 600px;height: 30px;width: 70px;background-color: #26284f;color: white;margin-bottom: 5px;" />
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
                            <asp:Label ID="CommentUserIdLabel" runat="server" Text='<%# Eval("CommentUserId") %>' Visible="false" />


                  
                 <div class="colelem comment_post_full" style="width:750px;">
                     <div class="position_content" style="margin-top: 15px;">
           <div class=" grpelem comment_post_profile_photo" style="margin-top: -11px;">
                <asp:ImageButton ID="ImageProfile2" runat="server" style="
    display: block;
" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">
                <asp:HyperLink ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' /><br />
                <asp:Label ID="CommentDateLabel" runat="server" style="
    display: block;
" Text='<%# Eval("CommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                     <div class="colelem comment_post_section">
                   <asp:Literal ID="LiteralComment" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="comment_post_like_section">
                     <%--<asp:Button ID="LinkButtonLike" runat="server" CommandName="LikeButtonComment" Text="Like" ></asp:Button>--%>
                 <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>

                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                                                    <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                         <hr style="
    width: 750px;
"/>   
          </div>
                        
                        <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
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
                    PostId:
                    <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' />
                    <br />
<br /></span>
                </SelectedItemTemplate>
             </asp:ListView>
                          </asp:Panel>
                      
                   </span>
                       </asp:Panel>
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
<br /></span>
               </SelectedItemTemplate>
             </asp:ListView>
     
     <asp:SqlDataSource ID="PostCommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT top 2 * FROM [PhotoComments] WHERE ([PhotoID] = @PhotoID) ORDER BY [CommentDate]" OnSelecting="PostCommentDataSource_Selecting">
                 <SelectParameters>
                     <asp:Parameter Name="PhotoID" Type="Object" />
                     
                 </SelectParameters>
             </asp:SqlDataSource>
     <asp:SqlDataSource ID="LikeDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [UserLikes]"></asp:SqlDataSource>
         </div>

        </div>
      </ContentTemplate>
    
   
 </asp:UpdatePanel>
    

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" OnSelecting="SqlDataSource1_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [PhotoStore] WHERE ([PhotoID] = @PhotoID)">
        <SelectParameters>
            <asp:Parameter Name="PhotoID" Type="Object" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

