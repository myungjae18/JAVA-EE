package member1.view;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import member1.model.Member1DAO;
import member1.model.Member1;

/*ȸ�� ���� ��� ���� ���� �ƴ� ���� ������ ���� ���α׷����� �����غ���..
���̰� �����̰� ��� ����� �� �ִ� ���� Ŭ������ �����ϱ� ���ؼ�
*/
public class MemberRegister extends JFrame{
	JTextField t_id, t_password;
	JButton bt;
	Member1DAO member1DAO;

	public MemberRegister(){
		t_id=new JTextField(20);
		t_password=new JTextField(20);
		bt=new JButton("regist");

		add(t_id);
		add(t_password);
		add(bt);

		bt.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				regist();
			}
		});

		setLayout(new FlowLayout());
		setSize(300, 150);
		setVisible(true);
		setDefaultCloseOperation(EXIT_ON_CLOSE);

		//member1DAO ����
		member1DAO=new Member1DAO();
	}
	public void regist(){
		//DAO�� Ȱ������
		String id=t_id.getText();
		String pw=t_password.getText();

		Member1 member1=new Member1(); //Member1�� ���� �Է�
		member1.setId(id);
		member1.setPassword(pw);

		int result=member1DAO.insert(member1);
		if(result==0){
			JOptionPane.showMessageDialog(this, "�Է� ����..");
		}else{
			JOptionPane.showMessageDialog(this, "�Է� ����!");
		}
	}

	public static void main(String[] args){
		new MemberRegister();
	}
}
