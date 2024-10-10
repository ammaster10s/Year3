namespace Signup
{
    partial class userpage
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            userdataGridView = new DataGridView();
            update = new Button();
            delete = new Button();
            ((System.ComponentModel.ISupportInitialize)userdataGridView).BeginInit();
            SuspendLayout();
            // 
            // userdataGridView
            // 
            userdataGridView.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            userdataGridView.Location = new Point(10, 9);
            userdataGridView.Margin = new Padding(3, 2, 3, 2);
            userdataGridView.Name = "userdataGridView";
            userdataGridView.RowHeadersWidth = 51;
            userdataGridView.RowTemplate.Height = 29;
            userdataGridView.Size = new Size(915, 176);
            userdataGridView.TabIndex = 0;
            userdataGridView.CellClick += userdataGridView_CellClick;
            userdataGridView.CellContentClick += userdataGridView_CellContentClick;
            // 
            // update
            // 
            update.BackColor = SystemColors.ButtonFace;
            update.Font = new Font("Segoe UI", 13.8F, FontStyle.Bold, GraphicsUnit.Point);
            update.Location = new Point(130, 192);
            update.Margin = new Padding(3, 2, 3, 2);
            update.Name = "update";
            update.Size = new Size(134, 32);
            update.TabIndex = 1;
            update.Text = "Update";
            update.UseVisualStyleBackColor = false;
            update.Click += update_Click;
            // 
            // delete
            // 
            delete.BackColor = SystemColors.ButtonFace;
            delete.Font = new Font("Segoe UI", 13.8F, FontStyle.Bold, GraphicsUnit.Point);
            delete.Location = new Point(654, 192);
            delete.Margin = new Padding(3, 2, 3, 2);
            delete.Name = "delete";
            delete.Size = new Size(134, 32);
            delete.TabIndex = 2;
            delete.Text = "Delete";
            delete.UseVisualStyleBackColor = false;
            delete.Click += delete_Click;
            // 
            // userpage
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(936, 232);
            Controls.Add(delete);
            Controls.Add(update);
            Controls.Add(userdataGridView);
            Margin = new Padding(3, 2, 3, 2);
            Name = "userpage";
            Text = "User page";
            Load += userpage_Load;
            ((System.ComponentModel.ISupportInitialize)userdataGridView).EndInit();
            ResumeLayout(false);
        }

        #endregion

        private DataGridView userdataGridView;
        private Button update;
        private Button delete;
    }
}