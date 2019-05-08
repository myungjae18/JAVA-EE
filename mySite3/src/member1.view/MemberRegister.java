package member1.view;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import member1.model.Member1DAO;
import member1.model.Member1;

/*회원 가입 등록 폼을 웹이 아닌 독립 실행형 응용 프로그램으로 구성해본다..
웹이건 응용이건 모두 사용할 수 있는 재사용 클래스를 검증하기 위해서
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

		//member1DAO 생성
		member1DAO=new Member1DAO();
	}
	public void regist(){
		//DAO를 활용하자
		String id=t_id.getText();
		String pw=t_password.getText();

		Member1 member1=new Member1(); //Member1에 정보 입력
		member1.setId(id);
		member1.setPassword(pw);

		int result=member1DAO.insert(member1);
		if(result==0){
			JOptionPane.showMessageDialog(this, "입력 실패..");
		}else{
			JOptionPane.showMessageDialog(this, "입력 성공!");
		}
	}

	public static void main(String[] args){
		new MemberRegister();
	}
}
