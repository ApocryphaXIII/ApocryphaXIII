import { Button, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const TankDispenser = (props) => {
  const { act, data } = useBackend();
  return (
    <Window width={275} height={103}>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item
              label="Plasma"
              buttons={
                <Button
                  icon={data.plasma ? 'square' : 'square-o'}
                  content="Dispense"
                  disabled={!data.plasma}
                  onClick={() => act('plasma')}
                />
              }
            >
              {data.plasma}
            </LabeledList.Item>
            <LabeledList.Item
              label="Oxygen"
              buttons={
                <Button
                  icon={data.oxygen ? 'square' : 'square-o'}
                  content="Dispense"
                  disabled={!data.oxygen}
                  onClick={() => act('oxygen')}
                />
              }
            >
              {data.oxygen}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
