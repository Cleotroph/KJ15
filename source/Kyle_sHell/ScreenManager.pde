import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;

volatile boolean gameWindowOpen = false;
volatile String currentNewSaveName;
volatile int resolutionMode = 2;
volatile boolean newGame;

float screenScale;
float screenOffset;
boolean screenOffsetDir;

void promptUser(){
  currentSaveName = getSaveNames()[0];
  JFrame promptWindow = new JFrame("Kyle's Hell prelauncher");
  
  promptWindow.addWindowListener(new WindowAdapter() {
    @Override
    public void windowClosing(WindowEvent windowEvent) {
      System.exit(5);
    }
  });
  
  JPanel panel1 = new JPanel();
  LayoutManager layout1 = new FlowLayout();
  panel1.setLayout(layout1);
  
  JButton loadSaveButton = new JButton("Load Game");
  
  loadSaveButton.addActionListener(new ReferenceListener(promptWindow){
    public void actionPerformed(ActionEvent e){
      newGame = false;
      gameWindowOpen = true;
      parent.setVisible(false);
      parent.dispose();
    }
  });
  
  JComboBox<String> saveNames = new JComboBox<String>(getSaveNames());
  saveNames.setSelectedIndex(0);
  saveNames.addActionListener(new ActionListener() {
    public void actionPerformed(ActionEvent e) {
      JComboBox combo = (JComboBox)e.getSource();
      currentSaveName = combo.getSelectedItem().toString();   
    }
  });
      
  panel1.add(saveNames);
  panel1.add(loadSaveButton);
  
  JPanel panel2 = new JPanel();
  LayoutManager layout2 = new FlowLayout();
  panel1.setLayout(layout2);
  
  
  JTextField newSaveName = new JTextField(15);
  newSaveName.getDocument().addDocumentListener(new TextDocumentListener(newSaveName));
  
  JButton newSaveButton = new JButton("New Game");
  
  newSaveButton.addActionListener(new ReferenceListener(promptWindow){
    public void actionPerformed(ActionEvent e){
      newGame = true;
      parent.setVisible(false);
      parent.dispose();
      gameWindowOpen = true;
    }
  });
  
  panel2.add(newSaveName);
  panel2.add(newSaveButton);
  
  JPanel panel3 = new JPanel();
  LayoutManager layout3 = new FlowLayout();
  panel3.setLayout(layout3);
  
  JComboBox<String> resolutions = new JComboBox<String>(new String[]{"720p", "1080p", "fullscreen 1", "fullscreen 2"});
  resolutions.setSelectedIndex(2);
  resolutions.addActionListener(new ActionListener() {
    public void actionPerformed(ActionEvent e) {
      JComboBox combo = (JComboBox)e.getSource();
      resolutionMode = combo.getSelectedIndex();
    }
  });
  
  panel3.add(new JLabel("Resolution:"));
  
  panel3.add(resolutions);
  
  JPanel container = new JPanel();
  container.setLayout(new BoxLayout(container, BoxLayout.Y_AXIS));
  
  container.add(panel1);
  container.add(panel2);
  container.add(panel3);
  
  promptWindow.getContentPane().add(container, BorderLayout.CENTER);
  promptWindow.setSize(300, 300);
  promptWindow.pack();
  promptWindow.setLocationRelativeTo(null);  
  promptWindow.setVisible(true);
}

abstract class ReferenceListener implements ActionListener{
  public JFrame parent;
  public ReferenceListener(JFrame parent){
    this.parent = parent;  
  }
  abstract public void actionPerformed(ActionEvent e);
}

class TextDocumentListener implements DocumentListener {
  JTextField parent;
  public TextDocumentListener(JTextField parent){
    this.parent = parent;  
  }
  public void changedUpdate(DocumentEvent e) {
    warn();
  }
  public void removeUpdate(DocumentEvent e) {
    warn();
  }
  public void insertUpdate(DocumentEvent e) {
    warn();
  }

  public void warn() {
     currentNewSaveName = parent.getText();
  }
}
