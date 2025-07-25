import {
  AnimatedNumber,
  Button,
  LabeledList,
  NoticeBox,
  Section,
} from 'tgui-core/components';
import { formatMoney } from 'tgui-core/format';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const BankMachine = (props) => {
  const { act, data } = useBackend();
  const { current_balance, siphoning, station_name } = data;
  return (
    <Window width={350} height={155}>
      <Window.Content>
        <NoticeBox danger>Authorized personnel only</NoticeBox>
        <Section title={station_name + ' Vault'}>
          <LabeledList>
            <LabeledList.Item
              label="Current Balance"
              buttons={
                <Button
                  icon={siphoning ? 'times' : 'sync'}
                  content={siphoning ? 'Stop Siphoning' : 'Siphon Credits'}
                  selected={siphoning}
                  onClick={() => act(siphoning ? 'halt' : 'siphon')}
                />
              }
            >
              <AnimatedNumber
                value={current_balance}
                format={(value) => formatMoney(value)}
              />
              {' cr'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
