<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="NotificationRace.aspx.cs" Inherits="Default4" %>

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
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" style="margin-top: 20px;margin-left: 110px;"
 UpdateMode="Always">
 <ContentTemplate>
             <asp:ListView ID="ListView1" runat="server" OnItemDataBound="ListView1_ItemDataBound" DataKeyNames="RaceId,LikeId,UserId" DataSourceID="SqlDataSource1" OnItemCreated="ListView1_ItemCreated" OnItemCommand="ListView1_ItemCommand">
               
                <EditItemTemplate>
                    <span style="">
                    <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' Visible="false" />
                   </span>
                    <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                         <asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' Visible="false" />
                            
                       <div class="colelem post_section_full_grid"><!-- post section -->
           <div class="position_content">
            <div class=" colelem post_profile_photo" style="
    margin-top: 0px;
">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />

            </div>

               <div class="post_top_info">

                   <asp:HyperLink ID="RacePostUserLabel" runat="server" Text='<%# Eval("RacePostUser") %>' NavigateUrl='<%# Eval("RacePostUserName","~/index_m.aspx?un={0}") %>' />
                   <br />
              
                   <asp:Label ID="RacePostDateLabel" runat="server" Text='<%# Eval("RacePostDate") %>' />
                   <br />
                         </div>
                   
            <div class="colelem post_section">
                    <asp:TextBox ID="RacePostTextBox" runat="server" Text='<%# Bind("RacePost") %>' Width="268" />
                   <br /></div>
               <div style="margin:10px">
               <asp:Button ID="UpdateButton" runat="server" CommandName="Updatepost" Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
               </div>
           </div>
                      <div class="like_dislike_share_section">
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
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <span>No data was returned.</span>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <span style="">RaceId:
                    <asp:TextBox ID="RaceIdTextBox" runat="server" Text='<%# Bind("RaceId") %>' />
                    <br />RacePost:
                    <asp:TextBox ID="RacePostTextBox" runat="server" Text='<%# Bind("RacePost") %>' />
                    <br />RacePostDate:
                    <asp:TextBox ID="RacePostDateTextBox" runat="server" Text='<%# Bind("RacePostDate") %>' />
                    <br />UserId:
                    <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                    <br />RaceContent:
                    <asp:TextBox ID="RaceContentTextBox" runat="server" Text='<%# Bind("RaceContent") %>' />
                    <br />RaceContentType:
                    <asp:TextBox ID="RaceContentTypeTextBox" runat="server" Text='<%# Bind("RaceContentType") %>' />
                    <br />RacePostUser:
                    <asp:TextBox ID="RacePostUserTextBox" runat="server" Text='<%# Bind("RacePostUser") %>' />
                    <br />
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                    <br /><br /></span>
                </InsertItemTemplate>
                <ItemTemplate>
                 <%--   <asp:Panel runat="server" ID="items">
                        
                    <span style="" id="racepost" runat="server" title='<%# Eval("RaceId") %>'>--%>
                   <%--     <button runat="server" value='<%# Eval("RaceId") %>' title='<%# Eval("SubCategory") %>' id="racepost" style="" class="race_post" onserverclick="racepost_ServerClick" >--%>
                        
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                        <div class="colelem post_section_full_grid"><!-- post section -->
                   <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                         <asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' Visible="false" />
                            
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo" style="
    margin-top: 0px;
">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />

            </div>

               <div class="post_top_info">
                <div class="post_edit_delete" style="margin-right: -5px;margin-top: -2px;">
                           <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
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
                   <asp:HyperLink ID="RacePostUserLabel" runat="server" Text='<%# Eval("RacePostUser") %>' NavigateUrl='<%# Eval("RacePostUserName","~/index_m.aspx?un={0}") %>' />
                   <br />
              
                   <asp:Label ID="RacePostDateLabel" runat="server" Text='<%# Eval("RacePostDate") %>' />
                   <br />
                   <asp:Label ID="RacePostSubCategory" runat="server" Text='<%# Eval("SubCategory") %>' />
                         </div>
                   
            <div class="colelem post_section">
                Title: <asp:Label ID="Label1" runat="server" Text='<%# Eval("PostTitle") %>' /><br />
                   <asp:Literal ID="RacePostLabel" runat="server" Text='<%# AddEmotes( Eval("RacePost").ToString()) %>' />
                   <br /></div>
               
           </div>
                      <div class="like_dislike_share_section">
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
                            <%--</button>--%>
                        <asp:Panel ID="PanelPostComment" runat="server">
 <asp:ListView ID="ListViewPostComment" runat="server" DataKeyNames="RaceId,LikeId,CommentUserId" DataSourceID="RacePostCommentDataSource" InsertItemPosition="LastItem" OnItemInserting="ListViewPostComment_ItemInserting" OnItemCreated="ListViewPostComment_ItemCreated" OnItemCommand="ListViewPostComment_ItemCommand">
            
            <EditItemTemplate>
                <span style="">CommentId:
                <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                <br />
                RaceComment:
                <asp:TextBox ID="RaceCommentTextBox" class='animated' TextMode="MultiLine" style="width:200px" runat="server" Text='<%# Bind("RaceComment") %>' />
                <br />
                RaceCommentUser:
                <asp:TextBox ID="RaceCommentUserTextBox" runat="server" Text='<%# Bind("RaceCommentUser") %>' />
                <br />
                RaceCommentDate:
                <asp:TextBox ID="RaceCommentDateTextBox" runat="server" Text='<%# Bind("RaceCommentDate") %>' />
                <br />
                RaceId:
                <asp:TextBox ID="RaceIdTextBox" runat="server" Text='<%# Bind("RaceId") %>' />
                <br />
                CommentContent:
                <asp:TextBox ID="CommentContentTextBox" runat="server" Text='<%# Bind("CommentContent") %>' />
                <br />
                CommentContentType:
                <asp:TextBox ID="CommentContentTypeTextBox" runat="server" Text='<%# Bind("CommentContentType") %>' />
                <br />
                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                <br /><br /></span>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <span>No Comments found.</span>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                  <%--<br />RaceCommentUser:
                <asp:TextBox ID="RaceCommentUserTextBox" runat="server" Text='<%# Bind("RaceCommentUser") %>' />--%>
                
                <%--<br />RaceId:
                <asp:TextBox ID="RaceIdTextBox" runat="server" Text='<%# Bind("RaceId") %>' />--%>
                <%--<br />CommentContent:
                <asp:TextBox ID="CommentContentTextBox" runat="server" Text='<%# Bind("CommentContent") %>' />--%>
               <%-- <br />CommentContentType:
                <asp:TextBox ID="CommentContentTypeTextBox" runat="server" Text='<%# Bind("CommentContentType") %>' />
                <br />--%>
                <asp:panel defaultbutton="InsertButton" runat="server">
                <span style="">
                   <div class="colelem comment_new_full">
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
                    

                        </div>
                <div class="comment_new_section" style="
    height: 88px;
">
                
                    <asp:TextBox ID="RaceCommentTextBox" class='animated' style="width:190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" Text='<%# Bind("RaceComment") %>' />
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
                    <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' Visible="false" />

                  
                 <div class="colelem comment_post_full">
                     <div class="position_content" >
           <div class=" grpelem comment_post_profile_photo">
                <asp:ImageButton ID="ImageProfile2" runat="server" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">
                <asp:HyperLink ID="RaceCommentUserLabel" runat="server" Text='<%# Eval("RaceCommentUser") %>' NavigateUrl='<%# Eval("RaceCommentUserName","~/index_m.aspx?un={0}") %>' /><br />
                <asp:Label ID="RaceCommentDateLabel" runat="server" Text='<%# Eval("RaceCommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                     <div class="colelem comment_post_section">
                   <asp:Literal ID="RaceCommentLabel" runat="server" Text='<%# AddEmotes( Eval("RaceComment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="comment_post_like_section">
              <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
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
                RaceComment:
                <asp:Label ID="RaceCommentLabel" runat="server" Text='<%# Eval("RaceComment") %>' />
                <br />
                RaceCommentUser:
                <asp:Label ID="RaceCommentUserLabel" runat="server" Text='<%# Eval("RaceCommentUser") %>' />
                <br />
                RaceCommentDate:
                <asp:Label ID="RaceCommentDateLabel" runat="server" Text='<%# Eval("RaceCommentDate") %>' />
                <br />
                RaceId:
                <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' />
                <br />
                CommentContent:
                <asp:Label ID="CommentContentLabel" runat="server" Text='<%# Eval("CommentContent") %>' />
                <br />
                CommentContentType:
                <asp:Label ID="CommentContentTypeLabel" runat="server" Text='<%# Eval("CommentContentType") %>' />
                <br />
<br /></span>
            </SelectedItemTemplate>
       </asp:ListView>
                            </asp:Panel>
     <asp:SqlDataSource ID="RacePostCommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [RaceComments] WHERE ([RaceId] = @RaceId) ORDER BY [RaceCommentDate]" OnSelecting="RacePostCommentDataSource_Selecting">
           <SelectParameters>
               <asp:Parameter Name="RaceId" Type="Object" />
           </SelectParameters>
       </asp:SqlDataSource>
   
                 <%--   </span>
                    </asp:Panel>--%>
                </ItemTemplate>
                <LayoutTemplate>
                    <div id="itemPlaceholderContainer" runat="server" style="">
                        <span runat="server" id="itemPlaceholder" />
                    </div>
                    <div style="">
                    </div>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <span style="">RaceId:
                    <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' />
                    <br />
                    RacePost:
                    <asp:Label ID="RacePostLabel" runat="server" Text='<%# Eval("RacePost") %>' />
                    <br />
                    RacePostDate:
                    <asp:Label ID="RacePostDateLabel" runat="server" Text='<%# Eval("RacePostDate") %>' />
                    <br />
                    UserId:
                    <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                    <br />
                    RaceContent:
                    <asp:Label ID="RaceContentLabel" runat="server" Text='<%# Eval("RaceContent") %>' />
                    <br />
                    RaceContentType:
                    <asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' />
                    <br />
                    RacePostUser:
                    <asp:Label ID="RacePostUserLabel" runat="server" Text='<%# Eval("RacePostUser") %>' />
                    <br />
<br /></span>
                </SelectedItemTemplate>
            </asp:ListView>
         </div>
    
            
            <asp:SqlDataSource ID="RacePostDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="RacePostDataSource_Selecting" SelectCommand="SELECT * FROM [RacePosts]" >
               <%-- <SelectParameters>
                    <asp:Parameter Name="UserId" Type="Object" />
                    <asp:Parameter Name="Category" />
                </SelectParameters>--%>
            </asp:SqlDataSource>
        </div>
     </ContentTemplate>
    
 </asp:UpdatePanel>
    

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" OnSelecting="SqlDataSource1_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [RacePosts] WHERE ([RaceId] = @RaceId)">
        <SelectParameters>
            <asp:Parameter Name="RaceId" Type="Object" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

