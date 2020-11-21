<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="photoalbums.aspx.cs" Inherits="Default4" %>

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

   <asp:ListView ID="ListView2" runat="server" OnItemCreated="ListView2_ItemCreated" OnItemDataBound="ListView2_ItemDataBound" DataKeyNames="PhotoID,LikeId,UserId" DataSourceID="PhotoStoreDS" GroupItemCount="3" OnItemCommand="ListView2_ItemCommand">
           
               <EditItemTemplate>
                   <td runat="server" style="">ID:
                       <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
                       <br />PhotoContent:
                       <asp:TextBox ID="PhotoContentTextBox" runat="server" Text='<%# Bind("PhotoContent") %>' />
                       <br />LikeId:
                       <asp:TextBox ID="LikeIdTextBox" runat="server" Text='<%# Bind("LikeId") %>' />
                       <br />CommentId:
                       <asp:TextBox ID="CommentIdTextBox" runat="server" Text='<%# Bind("CommentId") %>' />
                       <br />Date:
                       <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>' />
                       <br />
                       <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                       <br />
                       <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
                       <br /></td>
               </EditItemTemplate>
               <EmptyDataTemplate>
                   <table runat="server" style="">
                       <tr>
                           <td>No data was returned.</td>
                       </tr>
                   </table>
               </EmptyDataTemplate>
               <EmptyItemTemplate>
<td runat="server" />
               </EmptyItemTemplate>
               <GroupTemplate>
                   <tr id="itemPlaceholderContainer" runat="server">
                       <td id="itemPlaceholder" runat="server" ></td>
                   </tr>
               </GroupTemplate>
               <InsertItemTemplate>
                   <td runat="server" style="">ID:
                       <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
                       <br />PhotoContent:
                       <asp:TextBox ID="PhotoContentTextBox" runat="server" Text='<%# Bind("PhotoContent") %>' />
                       <br />LikeId:
                       <asp:TextBox ID="LikeIdTextBox" runat="server" Text='<%# Bind("LikeId") %>' />
                       <br />CommentId:
                       <asp:TextBox ID="CommentIdTextBox" runat="server" Text='<%# Bind("CommentId") %>' />
                       <br />Date:
                       <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>' />
                       <br />
                       <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                       <br />
                       <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                       <br /></td>
               </InsertItemTemplate>
               <ItemTemplate>
                   <td runat="server" style="">
                      <%-- <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />--%>
                      <%-- <br />PhotoContent:
                       <asp:Label ID="PhotoContentLabel" runat="server" Text='<%# Eval("PhotoContent") %>' />--%>
                     <%--  <div runat="server" style="margin:3px;cursor:pointer" onclick="">--%>
         <%--    <video id="embed1" controls="controls" src='<%# "AlbumHandler.ashx?id=" + Eval("PhotoID") %>' width="320" height="240">
                 <object>
                 <img src='<%# "AlbumHandler.ashx?id=" + Eval("PhotoID") %>' width="320" height="240" />
                     </object>
             </video>--%>  
                       <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                                              <asp:Label ID="PhotoIDLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />

                       <asp:HyperLink ID="HyperLinkViewer" runat="server">
                           
                           <asp:ImageButton style="height:190px;width:190px;margin-right: 12px;margin-bottom: 8px;" ID="ImageButton1" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' />
                     
                                  </asp:HyperLink> 
                           <asp:HiddenField ID="HiddenField1" runat="server" />
                           <ajaxToolkit:ModalPopupExtender ID="MPEPopImage"   CancelControlID="btnClose" DropShadow="true"  BackgroundCssClass="modalBackgroundImage" Drag="false" runat="server" TargetControlID="ImageButton1" PopupControlID="Panel1"></ajaxToolkit:ModalPopupExtender>
                      
               
           
                               <asp:Panel ID="Panel1" runat="server" style="z-index: 10000; height: 600px;display:none; opacity: 1; box-shadow: rgb(0, 0, 0) 5px 5px 5px; background-color: white;">
                                
                                             <div style="float:left">
                 <asp:Image Width="800" Height="600" ID="ImageButton2" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' />
                             </div>
                            <div style="float:right;margin:20px;">
                                 <asp:Button ID="btnClose" runat="server" Text="X" style="margin-left: -836px;display: block;clear: both;width: 20px;height: 20px;border-radius: 200px;margin-top: -34px;" />
                           <asp:ImageButton ID="Image2" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Style="vertical-align:top" /><br />
                       
                                <asp:Label ID="DateCreatedLabel" runat="server" Text='<%# Eval("Date") %>' /><br />
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Description") %>' /><br />
                           <asp:Button ID="btnDescription" runat="server" onClientClick="return false" Text="Add a Description" Style="vertical-align:top" CommandName="cmdDescription" />
                                <asp:Panel ID="pnlDescription" runat="server" Visible="true" Style="vertical-align:top">
                                    <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
                                    <asp:Button ID="btnDescriptionDone" runat="server" Text="Update" style="height: 20px;width: 70px;background-color: #26284f;color: white;" CommandName="DescriptionUpdate" CommandArgument='<%# Eval("PhotoID") %>' />
                                    <asp:Button ID="btnDescriptionCancel" runat="server" Text="Cancel" style="height: 20px;width: 70px;background-color: #26284f;color: white;" /><br />
                    <asp:ImageButton ID="LinkButtonLike2" CssClass="icon" runat="server" CommandArgument='<%# Eval("LikeId") %>' CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                                     <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />

                                </asp:Panel>
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:Panel ID="Panel2" runat="server" ScrollBars="Vertical" Height="300">
                                     
                                <asp:ListView ID="ListView4"  runat="server" DataKeyNames="PhotoID,LikeId,CommentUserId,CommentUser" DataSourceID="MediaDS" InsertItemPosition="LastItem" OnItemInserting="ListView3_ItemInserting" OnItemCreated="ListViewPostComment_ItemCreated" OnItemCommand="ListViewPostComment_ItemCommand">
                
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
                     <div class="colelem comment_new_full" >
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
           
                         
                    </div>
                <div class="comment_new_section" style="">
                <asp:TextBox ID="CommentTextBox" class='animated' Rows="1"  runat="server" TextMode="MultiLine" Text='<%# Bind("Comment") %>' style="width:190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Comment" style="margin-left: 210px;height: 30px;width: 70px;background-color: #26284f;color: white;margin-bottom: 5px;" />
                </div>
              
                
               <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                </div>
                        <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                    </span>
                        </asp:panel>
                </InsertItemTemplate>
                                   
                <ItemTemplate>
                 
                  
                    <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                            <asp:Label ID="CommentUserIdLabel" runat="server" Text='<%# Eval("CommentUserId") %>' Visible="false" />


                  
                 <div class="colelem comment_post_full">
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
                         <hr />   
          </div>
                        
                        <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                   
                      
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
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                
                                
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="SqlDataSource1_Selecting" SelectCommand="SELECT * FROM [PhotoComments]">
            <%--   <SelectParameters>
                   <asp:Parameter Name="PhotoID" Type="Object" />
               </SelectParameters>--%>
           </asp:SqlDataSource>
                                <asp:SqlDataSource ID="PhotoCommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT top 2 * FROM [PhotoComments] WHERE ([PhotoID] = @PhotoID) ORDER BY [CommentDate]" OnSelecting="PhotoCommentDataSource_Selecting">
                 <SelectParameters>
                     <asp:Parameter Name="PhotoID" Type="Object" />
                     
                 </SelectParameters>
             </asp:SqlDataSource>
                               </div>
                                      
                       </asp:Panel>
                      
                </div></div>
                   <%--        </ItemTemplate>
                       </asp:ListView> --%>
<%--                <embed id='embed1' autostart='false' runat="server" name='mediaPlayer' type='application/x-mplayer2' pluginspage='http://microsoft.com/windows/mediaplayer/en/download/'  displaysize='4' autosize='-1' bgcolor='darkblue' showcontrols='true' showtracker='-1' showdisplay='0' showstatusbar='-1' videoborder3d='-1' width='190' height='190'  designtimesp='5311' loop='false' src='<%# "AlbumHandler.ashx?id=" + Eval("PhotoID") %>' visible="true"/>--%>
                    <%--       </div>--%>

                     <%--  <br />LikeId:
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' />
                       <br />CommentId:
                       <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                       <br />Date:
                       <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("Date") %>' />--%>
                       </td>
               </ItemTemplate>
               <LayoutTemplate>
                   <table runat="server">
                       <tr runat="server">
                           <td runat="server">
                               <table id="groupPlaceholderContainer" runat="server" border="0" style="">
                                   <tr id="groupPlaceholder" runat="server">
                                   </tr>
                               </table>
                           </td>
                       </tr>
                       <tr runat="server">
                           <td runat="server" style=""></td>
                       </tr>
                   </table>
               </LayoutTemplate>
               <SelectedItemTemplate>
                   <td runat="server" style="">ID:
                       <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                       <br />PhotoContent:
                       <asp:Label ID="PhotoContentLabel" runat="server" Text='<%# Eval("PhotoContent") %>' />
                       <br />LikeId:
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' />
                       <br />CommentId:
                       <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                       <br />Date:
                       <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("Date") %>' />
                       <br /></td>
               </SelectedItemTemplate>
           </asp:ListView>
     <asp:SqlDataSource ID="PhotoStoreDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="PhotoStoreDS_Selecting" SelectCommand="SELECT PhotoStore.*, PhotoAlbums.* FROM PhotoStore INNER JOIN PhotoAlbums ON PhotoStore.ID = PhotoAlbums.ID WHERE (PhotoStore.ID = @ID)">
               <SelectParameters>
                   <asp:Parameter Name="ID" Type="Object" />
               </SelectParameters>
           </asp:SqlDataSource>
       <asp:SqlDataSource ID="MediaDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [PhotoComments] WHERE ([PhotoID] = @PhotoID) ORDER BY [CommentDate]" OnSelecting="MediaDS_Selecting">
                 <SelectParameters>
                     <asp:Parameter Name="PhotoID" Type="Object" />
                     
                 </SelectParameters>
             </asp:SqlDataSource>
     <asp:SqlDataSource ID="PhotoAlbumsDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="PhotoAlbumsDS_Selecting" SelectCommand="SELECT * FROM [PhotoAlbums] WHERE ([UserId] = @UserId) ORDER BY [DateCreated]">
                <SelectParameters>
                    <asp:Parameter Name="UserId" Type="Object" />
                </SelectParameters>
            </asp:SqlDataSource>
     
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
    

    <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" OnSelecting="SqlDataSource1_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [PhotoStore] WHERE ([PhotoID] = @PhotoID)">
        <SelectParameters>
            <asp:Parameter Name="PhotoID" Type="Object" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
</asp:Content>

