function htext_x = Arrow_Xlabel(ha,str,pos,Attribute_Set)
% htext_x = Arrow_Xlabel(ha,str,pos,Attribute_Set)
% ���ü�ͷ������ͼ�ε�X���ı���ע
% ha              ������(axes)�����Ĭ��Ϊ��ǰ��������
% str             �ַ���
% pos             ��ͷ������λ�÷���,Ĭ��Ϊ'pp'���������볤��6����ֵ������ֱ�ӹ涨��ͷλ�ã�ȡֵ��plot_with_arrow
% Attribute_Set   ��ע�ı��������ã�Textbox�����Ծ���������
%                 ӦΪ����Ԫ�����飬һ��Ϊ����������һ��Ϊ����ֵ
% htext_x         ��ע�ı��ľ����Ҳ��ͨ�������������ı�����
% By ZFS@wust 2012.04.21
% See Also: Arrow_XY, Arrow_Ylabel, plot_with_arrow�� saturate
% ��ȡ����Matlab/Simulinkԭ�����Ϻͳ������ע΢�Ź��ںţ�Matlab Fans

% ����Ĭ��ֵ
if nargin < 4 
    Attribute_Set = [];
end
if nargin < 3 || isempty(pos)
    pos = 'pp';
end
if isempty(ha)   % Ĭ��Ϊ��ǰ������
    ha = gca;
end


% ���ı���Ӧ�÷��õ�λ��
rec = get( ha,'position' );                  % ������λ��

if isnumeric(pos)
      [X0 Y0 Xi Yi X_y Y_x] =  deal( pos(1),pos(2),...
      pos(3),pos(4),pos(5),pos(6)  );         % ֱ������ļ�ͷ����ʼλ��
      pos = '';                               % pos��Ϊ�ַ���ָʾ��ʽ����������ĵ���
      if Xi - X0 < 0 
          pos(1) = 'n';
      else
          pos(1) = 'p';
      end
      if Yi - Y0 < 0 
          pos(2) = 'n';
      else
          pos(2) = 'p';
      end
else
      [X0 Y0 Xi Yi X_y Y_x] = Arrow_XY(rec,pos);   % ��ͷ������λ��
end

if strcmp( pos(1),'n' )          % X����
    tx0 = Xi + 0.02;
    txi = tx0 + 0.2;
else                             % X����
    txi = Xi - 0.01;
    tx0 = txi - 0.2;
end
if strcmp( pos(2),'n' )           % Y����
    ty = Y_x - 0.06 ;
else                              % Y����
    ty = Y_x + 0.01 ;
end

text_pos = [tx0 ty txi-tx0 0.1];
text_pos = saturate(text_pos,1,0);


% �����ı��򣬲����û�������
hf = get(ha,'parent');      % ��ȡ�������ͼ�ξ��
htext_x = annotation(hf,'textbox',text_pos);
color = get(hf,'color');    % ��ȡfigure������ɫ
set(htext_x,'String',str,'EdgeColor',color,'VerticalAlignment','bottom','FitBoxToText','on','Margin',0); 
                            % �߿���ɫΪfigure������ɫ���¶���,�Զ��������ο����ʺ����֣����ο����Ϊ0
if strcmp( pos(1),'n' )     % ����x�᷽���������Ҷ��뷽ʽ
    set(htext_x,'HorizontalAlignment','left');
else
    set(htext_x,'HorizontalAlignment','right');
    % �Ҷ���ʱ�����Զ��������ο����ҪУ���ı���λ��
    text_pos_get = get(htext_x,'position');
    text_pos_set = text_pos_get;
    text_pos_set(1) = text_pos_get(1) + txi - ( text_pos_get(1)+text_pos_get(3) );
    set(htext_x,'position',text_pos_set)
end
                            
% ���ø�������
if ~isempty(Attribute_Set)
  [m n] = size(Attribute_Set);    % mΪ��Ҫ���õ�������Ŀ��n����Ϊ2                        
  if m == 2 && n == 1
           set( htext_x,Attribute_Set{ii,1},Attribute_Set{ii,2} );
  elseif n ~= 2
      error('Attribute_Set must be Two-Row Cell Matrix��');
  else
      for ii = 1:m
           set( htext_x,Attribute_Set{ii,1},Attribute_Set{ii,2} ); 
      end
  end
end

