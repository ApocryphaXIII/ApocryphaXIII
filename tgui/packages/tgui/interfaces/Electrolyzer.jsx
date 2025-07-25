import {
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Electrolyzer = (props) => {
  const { act, data } = useBackend();
  return (
    <Window width={400} height={305}>
      <Window.Content>
        <Section
          title="Power"
          buttons={
            <>
              <Button
                icon="eject"
                content="Eject Cell"
                disabled={!data.hasPowercell || !data.open}
                onClick={() => act('eject')}
              />
              <Button
                icon={data.on ? 'power-off' : 'times'}
                content={data.on ? 'On' : 'Off'}
                selected={data.on}
                disabled={!data.hasPowercell}
                onClick={() => act('power')}
              />
            </>
          }
        >
          <LabeledList>
            <LabeledList.Item label="Cell" color={!data.hasPowercell && 'bad'}>
              {(data.hasPowercell && (
                <ProgressBar
                  value={data.powerLevel / 100}
                  content={data.powerLevel + '%'}
                  ranges={{
                    good: [0.6, Infinity],
                    average: [0.3, 0.6],
                    bad: [-Infinity, 0.3],
                  }}
                />
              )) ||
                'None'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
